class AddUserIdRooms < ActiveRecord::Migration[5.2]
  def change
  	add_column :rooms, :user_id, :bigint
  	add_index :rooms, :user_id
  end
end
