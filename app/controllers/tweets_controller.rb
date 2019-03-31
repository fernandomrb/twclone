class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :update, :show, :destroy, :like, :dislike, :reply, :retweet, :destroy_retweet]
  before_action :authenticate_user!, except: [:show]
  
  include TweetsHelper
  
  def index
    @tweets = Tweet.of_followed_users(current_user).order("created_at DESC")
    @tweet = Tweet.new
  end

  def new
    @tweet = Tweet.new
    if params[:id]
      @src_tweet = Tweet.find(params[:id])
      @retweet = true
    end
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    @tweet.parent = Tweet.find(params[:parent]) unless params[:parent].nil?
    respond_to do |format|
      if @tweet.save
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
  
  def reply 
    respond_to do |format|
      format.js
    end
  end
  
  def retweet
    @retweet = current_user.tweets.new(tweet_params)
    @retweet.src_tweet = @tweet
    @retweet.body = @tweet.body
    respond_to do |format|
      if @retweet.save
        format.js
      else
        format.html { flash[:warning] = "An error has ocurred, try again." }
      end
    end
  end
  
  def destroy_retweet
    @retweet = @tweet.retweets.find_by(user_id: current_user)
    respond_to do |format|
      if @retweet.destroy
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
      if current_user.retweet_it?(@tweet)
        @retweet = @tweet.retweets.find_by(user_id: current_user)
      end
      respond_to do |format|
        format.json { head :no_content }
        format.js
      end
    end
  end

  def dislike
    if @tweet.unliked_by current_user
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
      params.require(:tweet).permit(:body, :parent_id, :quote)
    end

end
