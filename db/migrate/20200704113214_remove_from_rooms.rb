class RemoveFromRooms < ActiveRecord::Migration[5.2]
  def change
  	remove_column :rooms, :user_id
  end
end
