class RoomUsersController < ApplicationController
  
  def index
    @room = Room.find(params[:id])if params[:id]
    @room_users = RoomUser.where(id: params[:id])
    @users = User.where.not(id: @room_users.pluck(:user_id))
  end
end
 