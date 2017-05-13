class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:show]
  
  def index
    @tweets = Tweet.all.order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to @tweet, success: "Your tweet has been sent."
    else
      render :new
    end

  end

  def show

  end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, success: "Your tweet has been updated."
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @tweet.destroy 
      redirect_to root_path, notice: "Your tweet has been deleted."
    end
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body)
    end

end
