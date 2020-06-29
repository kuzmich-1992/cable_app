class RoomUsersController < ApplicationController
  
  def index
    @room = Room.find(params[:id])if params[:id]
    @room_users = RoomUser.where(id: params[:id])
    @users = User.where.not(id: @room_users.pluck(:user_id))
  end


  def create
    @room = Room.find(params[:id])if params[:id]
    redirect_with_flash unless member_of_room

    user = User.find(params[:id])
    room_user = RoomUser.new(user_id: user.id,
                                room_id: @room.id)
    if room_user.save
      json_hash = {username: user.username, id: user.id}
      JSON.generate(json_hash)
    else
      #error handling
    end
  end
end
