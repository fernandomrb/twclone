class RegistrationsController < Devise::RegistrationsController

	def preRegister 
		#@full_name = params[:full_name]
		session[:email] = pre_register_params[:email]
		session[:password] = pre_register_params[:password]
		redirect_to new_user_registration_path
	end

	private
		def pre_register_params
			params.require(:user).permit(:full_name, :email, :password)
		end
end