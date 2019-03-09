class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  before_action :configure_permitted_parameters, if: :devise_controller?

	include ConversationsHelper

  protected

	  def configure_permitted_parameters
	  	devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
	    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :name, :email, :password,
	      :password_confirmation, :remember_me) }
	    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password,
	      :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
	      :cover, :cover_cache, :remove_cover, :name, :bio) }
		end
		
		def send_notification(recipient, action, notifiable)
			Notification.create(recipient: recipient, actor: current_user, action: action, notifiable: notifiable)
		end

		def notifications_count
			Notification.where(recipient: current_user).unread.count
		end

		def not_found
			raise ActionController::RoutingError.new('Not Found')
		end
end
