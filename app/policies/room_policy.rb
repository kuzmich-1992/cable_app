class RoomPolicy < ApplicationPolicy
  attr_reader :user, :room

  def initialize(room,current_user)
    @room = room
    @current_user = current_user
  end

  def show?
    # binding.pry
    record.current_user.room_users.find_by(room_id: room.id)&.role == "admin" || record.current_user.room_users.find_by(room_id: room.id)&.role == "user"
  end

  def destroy?
    @current_user.room_users.find_by(room_id: room.id)&.role == 'admin'
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
