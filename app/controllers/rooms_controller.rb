class RoomsController < ApplicationController
  # Loads:
  # @rooms = all rooms
  # @room = current room when applicable
  before_action :load_entities
  before_action :correct_user,   only: :destroy
  
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(permitted_parameters)
    if @room.save
      current_user.room_users.create(room_id: @room.id, role: 'admin')
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    redirect_with_flash unless member_of_room
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.room_users.all.delete_all
    @room.destroy
    redirect_to rooms_path
  end

  protected

  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:room_id]) if params[:room_id]
  end

  def permitted_parameters
    params.require(:room).permit(:name,:user_id,:room_id)
  end

  def correct_user
    @room = current_user.rooms.find_by(id: params[:id])
    redirect_to room_url if @room.nil?
  end
end