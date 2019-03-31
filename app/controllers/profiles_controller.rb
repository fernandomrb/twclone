class ProfilesController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find_by(username: params[:username]) || not_found
		@tweets = @user.tweets.order("created_at DESC")
		@notifications_count = notifications_count
	end

end