class RoomPolicy < ApplicationPolicy
  
  attr_reader :user, :room

  def initialize(room,user)
    @room = room
    @user = user
  end

  # def show?
  #   user.room_users.find_by(room_id: room.id)&.role == 'user' or user.room_users.find_by(room_id: room.id)&.role == 'admin'
  # end

  # def destroy?
  #   user.room_users.find_by(room_id: room.id)&.role == 'admin'
  # end
end