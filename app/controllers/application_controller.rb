class ApplicationController < ActionController::Base
  # include Pundit
  
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user

  helper_method :member_of_room

  helper_method :admin_of_room

  def after_sign_in_path_for(_resource)
    rooms_path
  end

  def after_sign_out_path_for(resource_or_scope)
    user_session_path
  end

  protected

  def member_of_room
    !!@room.room_users.find_by(room_id: room.id)&.role == 'user' or !!@room.room_users.find_by(room_id: room.id)&.role == 'admin'
  end

  def admin_of_room
    !!@room.room_users.find_by(room_id: room.id)&.role == 'admin'
  end

  def user_not_authorized
    flash[:alert] = "Accesss denied"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username])
  end
end