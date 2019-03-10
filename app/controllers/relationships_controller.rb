class RelationshipsController < ApplicationController
	before_action :set_user

  def follow_user
      relationship = current_user.follow(@user.id)
	  if relationship
			Notification.send_notification(@user, current_user, "follows", relationship)
			respond_to do |format|
				format.json { head :no_content }
				format.js
			end
		end
  end

  def unfollow_user
	  if current_user.unfollow(@user.id)
			Notification.find_by(recipient: @user, actor: current_user, notifiable_type: "Follow").destroy
			respond_to do |format|
				format.json { head :no_content }
				format.js
			end
		end
  end

  private
  	def set_user
  		@user = User.find_by(username: params[:username])
  	end
end
