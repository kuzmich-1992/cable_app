class RoomsController < ApplicationController
  # Loads:
  # @rooms = all rooms
  # @room = current room when applicabl

  before_action :load_entities
  helper_method :member_of_room
  helper_method :admin_of_room

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new(params[:name])
  end

  def create
    @room = current_user.rooms.build(permitted_parameters)
    if @room.save
      @room_user = current_user.room_users.create(room_id: @room.id, role: 'admin')
      flash[:success] = "Room #{@room.name} was created successfully"
      if @room_user.save
        redirect_to rooms_path
      end
    end
  end

  def show
    if member_of_room
    @room = Room.find(params[:id]) 
    unless RoomPolicy.new(current_user, @room).show?
      raise Pundit::NotAuthorizedError, "not allowed to update? this #{@room.inspect}"
    end
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
    end
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
    if admin_of_room
    @room = Room.find(params[:id])
    # unless RoomPolicy.new(current_user, @room).destroy?
    #   binding.pry
    #   raise Pundit::NotAuthorizedError, "not allowed to update? this #{@room.inspect}"
    # end
    @room.room_users.all.delete_all
    @room.destroy 
    redirect_to rooms_path
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
end