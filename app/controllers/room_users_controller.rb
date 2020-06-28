class RoomUsersController < ApplicationController
  def index
    @room = Room.find(params[:id])if params[:id]
    @room_users = RoomUser.where(id: params[:id])
    @users = User.where.not(id: @room_users.pluck(:user_id))
  end
  
  def new
    @users = User.all
    render
  end

  def bulk_create
    @users = User.where(id: params[:user_ids])
    @room = Room.find(params[:room_id])
    @users.each do |user|
      RoomUser.create(user_id: user.id, room: @room, role: 'user')
    end
    redirect_to @room
  end
end


 