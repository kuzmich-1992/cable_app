class AddRoleToRoomUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :room_users, :role, :string
  end
end
