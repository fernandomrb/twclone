class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :update, :show, :destroy, :like, :dislike]
  before_action :authenticate_user!, except: [:show]
  
  def index
    @tweets = Tweet.of_followed_users(current_user).order("created_at DESC")
    @tweet = Tweet.new
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      respond_to do |format|
        format.json { head :no_content }
        format.js { flash.now[:success] = "Your tweet has been created." }
      end
    else
      format.json { render json: @tweet.errors.full_messages, 
                            status: :unprocessable_entity }
    end

  end

  def show

  end

  def update
    if @tweet.update(tweet_params)
      respond_to do |format|
        format.json { head :no_content }
        format.js
      end
    else
      format.json { render json: @tweet.errors.full_messages, 
                            status: :unprocessable_entity }
    end
  end

  def edit
  end

  def like
    if @tweet.like_by current_user
      respond_to do |format|
        format.json { head :no_content }
        format.js
      end
    end
  end

  def dislike
    if @tweet.unliked_by current_user
      respond_to do |format|
        format.json { head :no_content }
        format.js
      end
    end
  end

  def destroy
    @tweet.destroy 
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body, :like)
    end

end
