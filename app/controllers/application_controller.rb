class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :positon, :level])
		end

	private
		def after_sign_in_path_for(resource)
			user_path(resource)
		end
end
