class RoomUsersController < ApplicationController
  
  def index
    @room = Room.find(params[:format])if params[:format]
    @room_users = RoomUser.where(room_id: params[:format])
    @users = User.where.not(id: @room_users.pluck(:user_id))
  end

  def create
    @room = Room.find(params[:room_user_id] )if params[:room_user_id]
    json_hash = []
    params[:users].values.each do |user|
      if user[:is_added] == 'true'
        u = User.find(user[:user_id])
        room_user = RoomUser.create(user_id: user[:user_id], room_id: @room.id, role: 'user')
        if room_user.id
          json_hash << {username: u.username, id: room_user.id}
        else
          return render json: {error: room_user.errors}
        end
      end
    end
  end

  def destroy
    @room = Room.find(params[:room_user_id])
    json_hash = []
    params[:users].values.each do |user|
      if user[:is_deleted] == 'true'
        u = RoomUser.find(user[:user_id])
        room_user = RoomUser.destroy(user[:user_id])
        if room_user.id
          respond_to do |format|
            format.html { redirect_to rooms_url }
            format.json { head :no_content }
          end
        end
      end
    end
  end
end
