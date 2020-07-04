class RemoveFromRoomsindex < ActiveRecord::Migration[5.2]
  def change
  	remove_index(:rooms, name:"index_rooms_on_user_id")
  end
end
