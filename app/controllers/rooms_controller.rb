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
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
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
    if @room.destroy
      respond_to do |format|
        format.html { redirect_to rooms_url, notice: 'room was destroyed.' }
        format.json { head :no_content }
      end
    else
      render 'deletion error'
    end
  end

  protected

  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:room).permit(:name,:user_id)
  end

  def correct_user
    @room = current_user.rooms.find_by(id: params[:id])
    redirect_to root_url if @room.nil?
  end
end