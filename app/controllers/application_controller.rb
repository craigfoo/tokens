class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << [:username, :first_name, :last_name]
		devise_parameter_sanitizer.for(:account_update) << [:username, :first_name, :last_name, :avatar]
	end

	
    def logging(argument)
    	logger.debug("***This is a debug message: " + argument + " ***")    	
    end

end
