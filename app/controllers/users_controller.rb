class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        params[:term] ? @users = User.search_by_name_and_username(params[:term]) : @users = User.all
        if @users.any?
            respond_to do |format|
                format.html
                format.json
            end
        else
            render :json  => { errors: "No user was found" }
        end
    end
end