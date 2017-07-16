class RegistrationsController < Devise::RegistrationsController
	after_Action :clean_session, except: [:preRegister]
	def preRegister 
		#@full_name = params[:full_name]
		session[:name] = pre_register_params[:name]
		session[:email] = pre_register_params[:email]
		session[:password] = pre_register_params[:password]
		redirect_to new_user_registration_url
	end

	private
		def pre_register_params
			params.require(:user).permit(:name, :email, :password)
		end
		
		def clean_session
			session[:name] = nil
			session[:email] = nil
			session[:password] = nil
		end
end