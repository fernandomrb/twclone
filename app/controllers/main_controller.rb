class MainController < ApplicationController

	def index
		@disabled_search = true
	end

	def search
		@query = params[:q] || "*"
		@users = User.search(@query)
		@tweets = Tweet.search(@query)
	end
end