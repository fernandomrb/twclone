class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  before_action :configure_permitted_parameters, if: :devise_controller?

	include ConversationsHelper

	def self.renderer_with_signed_in_user(user)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap { |i|
      i.set_user(user, scope: :user, store: false, run_callbacks: false)
    }
    renderer.new('warden' => proxy)
  end

  protected

	  def configure_permitted_parameters
	  	devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
	    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :name, :email, :password,
	      :password_confirmation, :remember_me) }
	    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password,
	      :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar,
	      :cover, :cover_cache, :remove_cover, :name, :bio) }
		end

		def notifications_count
			Notification.where(recipient: current_user).unread.count
		end

		def not_found
			raise ActionController::RoutingError.new('Not Found')
		end

end
