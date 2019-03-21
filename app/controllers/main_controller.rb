class MainController < ApplicationController

	def index
		@disabled_search = true
	end

	def search
		@query = params[:q] || "*"
		if params[:f]
			@show_users = true 
			@users = User.search(@query)
		else
			@tweets = Tweet.search(@query, order: { created_at: :desc })
		end
	end
end