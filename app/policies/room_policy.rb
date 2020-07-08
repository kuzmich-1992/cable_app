class RoomPolicy < ApplicationPolicy
  attr_reader :user, :room

  def initialize(user, room)
    @user = user
    @room = room
  end

  def show?
    @room.room_users.find_by(user_id: @user.id).role == 'admin' || @user.present? && @room.room_users.find_by(user_id: @user.id).role == 'user'
  end

  def destroy
    @room.room_users.find_by(user_id: @user.id).role == 'admin'
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
