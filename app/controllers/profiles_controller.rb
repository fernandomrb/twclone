class ProfilesController < ApplicationController

	def index

	end

	def show
		@user = User.find_by(id: params[:id])
		@tweets = @user.tweets
	end

end