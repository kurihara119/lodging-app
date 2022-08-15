class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.text :room_text
      t.integer :price
      t.string :address
      t.string :img
      t.integer :user_id

      t.timestamps
    end
  end
end
