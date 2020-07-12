class RoomUserPolicy < ApplicationPolicy
  attr_reader :user, :room_user, :room

  def initialize(user, room_user, room)
    @user = user
    @room_user = room_user
    @room = room
  end

  def index?
    @user.present? && @room_user.find_by(user_id: @user.id).role == 'admin'
  end

  def create?
    @user.present? && @room_user.find_by(user_id: @user.id).role == 'admin'
  end

  def destroy?
    @user.present? && @room_user.find_by(user_id: @user.id).role == 'admin'
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end