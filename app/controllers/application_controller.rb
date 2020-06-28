class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user, :member_of_room, :redirect_with_flash

  def after_sign_in_path_for(_resource)
    rooms_path
  end

  def after_sign_out_path_for(resource_or_scope)
    user_session_path
  end

  def member_of_room
    !!@room.room_users.find_by(user_id: current_user.id)
  end

  def redirect_with_flash
    flash[:notice] = "You are not a member of that room"
    redirect_to rooms_path
  end

  protected

  def user_not_authorized
    flash[:alert] = "Accesss denied"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username])
  end
end