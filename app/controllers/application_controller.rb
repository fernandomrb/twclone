class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  layout :layout_by_resource
  
  private
	  def layout_by_resource
		  if devise_controller? && resource_name == :user && action_name == "new"
		    "registration"
		  else
		    "application"
		  end
		end
end
