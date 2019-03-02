class ProfilesController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find_by(id: params[:id])
		@tweets = @user.tweets.order("created_at DESC")
		@notifications_count = notifications_count
	end

end