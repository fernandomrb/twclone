class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :update, :show, :destroy, :like, :dislike, :reply, :destroy_retweet]
  before_action :authenticate_user!, except: [:show]
  
  include TweetsHelper
  
  def index
    @tweets = Tweet.of_followed_users(current_user).order("created_at DESC")
    @tweet = Tweet.new
    @notifications_count = notifications_count
    @messages_count = messages_count
  end

  def new
    @tweet = Tweet.new
    if params[:src_tweet]
      @src_tweet = Tweet.find(params[:src_tweet])
    elsif params[:parent_id]
      @parent = Tweet.find(params[:parent_id])
    end
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    @tweet.parent = Tweet.find(params[:parent]) unless params[:parent].nil?
    respond_to do |format|
      if @tweet.save 
        Notification.send_notification(@tweet.parent.user, current_user, "reply", @tweet) if @tweet.parent && @tweet.parent.user != current_user
        format.json { head :no_content }
        format.js { flash.now[:success] = "Your tweet has been created." }
        format.html { redirect_to tweets_url, notice: "Your tweet has been created." }
      else
        format.json { render json: @tweet.errors.full_messages, 
                           status: :unprocessable_entity }
        format.js
      end
    end

  end
  
  def retweet
    @tweet = Tweet.find(params[:src_tweet])
    @retweet = current_user.tweets.new(tweet_params)
    @retweet.src_tweet = @tweet
    @retweet.body = @tweet.quote.present? ? @tweet.quote : @tweet.body
    respond_to do |format|
      if @retweet.save
        Notification.send_notification(@tweet.user, current_user, "retweet", @tweet) unless current_user == @tweet.user
        format.js
      else
        format.html { flash[:warning] = "An error has ocurred, try again." }
      end
    end
  end
  
  def destroy_retweet
    @retweet = @tweet.retweets.find_by(user: current_user)
    respond_to do |format|
      if @retweet.destroy
        Notification.find_by(recipient: @tweet.user, actor: current_user, action: "retweet").destroy unless @tweet.user == current_user
        format.html { flash[:success] = "Your retweet has been deleted." }
        format.json { head :no_content }
        format.js
      else
        format.html { flash[:warning] = "An error has ocurred, try again." }
        format.json { render json: @tweet.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  def show
    @tweets = @tweet.replies
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.json { head :no_content }
        format.js
        format.html { redirect_to tweets_url, notice: "Your tweet has been updated." }
      else
        format.json { render json: @tweet.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def like
    if @tweet.like_by current_user
      Notification.send_notification(@tweet.user, current_user, "liked", @tweet) unless current_user == @tweet.user
      @retweet = @tweet.get_src_tweet if @tweet.has_src_tweet?
      respond_to do |format|
        format.json { head :no_content }
        format.js
      end
    end
  end

  def dislike
    if @tweet.unliked_by current_user
      Notification.find_by(recipient: @tweet.user, actor: current_user, action: "liked").destroy unless @tweet.user == current_user
      if current_user.retweet_it?(@tweet)
        @retweet = @tweet.retweets.find_by(user_id: current_user)
      end
      respond_to do |format|
        format.json { head :no_content }
        format.js
      end
    end
  end

  def destroy
    if @tweet.destroy 
      Notification.find_by(recipient: @tweet.parent.user, actor: current_user, action: "reply").destroy if @tweet.parent && @tweet.parent.user != current_user
      respond_to do |format|
        format.json { head :no_content }
        format.js
        format.html { redirect_to tweets_url, notice: "Your tweet has been deleted." }
      end
    end
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body, :parent, :quote, :src_tweet)
    end

    def trigger_tweet_to_followers(tweet)
      
    end
end
