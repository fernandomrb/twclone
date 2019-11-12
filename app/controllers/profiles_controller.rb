class ProfilesController < ApplicationController
	before_action :set_user, except: [:index]
	before_action :set_notifications_count, except: [:index]

	def index
		@users = User.all
	end

	def show
		@tweets = @user.tweets.order("created_at DESC")
		@notifications_count = notifications_count
		# respond_to do |format|
		# 	format.html
		# 	format.js
		# end
	end

	def following
		@following = @user.following.order("created_at DESC")

	end

	def followers
		@followers = @user.followers.order("created_at DESC")
	end

	private
		def set_user
			@user = User.find_by(username: params[:username]) || not_found
		end

		def set_notifications_count
			@notifications_count = notifications_count
		end

end