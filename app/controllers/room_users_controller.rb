class RoomUsersController < ApplicationController

  helper_method :current_user
  # before_action :correct_user,   only: :index
 
  # def index
  #   @room = Room.find(params[:id])if params[:id]
  #   @room_users = RoomUser.where(id: params[:id])
  #   @users = User.where.not(id: @room_users.pluck(:user_id))
  # end

  def index
    @room = Room.find(params[:id])if params[:id]
    @room_users = RoomUser.where(room_id: params[:room_id])
    @users = User.where.not(id: @room_users.pluck(:user_id))
  end
  
  def new
    @users = User.all
    render
  end

  def create
    @room = Room.find(params[:room_id])
    redirect_with_flash unless member_of_room
    @user = User.find(params[:user_id])
    @room_user = RoomUser.new(user_id: @user.id,
                                room_id: @room.id)
    if @room_user.save
      json_hash = {username: @user.username, user_id: @user.id}
      render text: JSON.generate(json_hash)
    else
      #error handling
    end
  end

  # def correct_user
  #   @room = current_user.rooms.find_by(id: params[:id])
  #   redirect_to room_users_url if @room.nil?
  # end

  # def bulk_create
  #   @users = User.where(id: params[:user_ids])
  #   @room = Room.find(params[:room_id])
  #   @users.each do |user|
  #     RoomUser.create(user_id: user.id, room: @room, role: 'user')
  #   end
  #   redirect_to @room
  # end
end


 