class RoomPolicy < ApplicationPolicy
  # attr_reader :user, :room

  def initialize(room,current_user)
    @room = room
    @user = current_user
  end

  # def show?
  #   # binding.pry
  #   record.user.room_users.find_by(user_id: user.id).try(:role) == "admin" || current_user.room_users.find_by(user_id: user.id).try(:role) == "user"
  # end

  def show?
    @user.present? && (record.user == user || user.admin?) or @user.present? && (record.user == user || user.user?)
  end

  def destroy
    record.user.room_users.find_by(room_id: room.id)&.role == 'admin'
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
