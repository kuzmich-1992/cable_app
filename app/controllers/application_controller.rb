class ApplicationController < ActionController::Base
  include Pundit
  
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    rooms_path
  end

  def after_sign_out_path_for(resource_or_scope)
    user_session_path
  end

  protected

  def user_not_authorized
    flash[:alert] = "Accesss denied"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username])
  end
end