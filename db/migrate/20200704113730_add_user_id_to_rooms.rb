class AddUserIdToRooms < ActiveRecord::Migration[5.2]
  change_table(:rooms) do |t|
    t.references :user, index: true, foreign_key: true
    add_index :rooms, [:user_id, :created_at]
  end
end
