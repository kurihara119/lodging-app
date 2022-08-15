class RenameImgColumnToRooms < ActiveRecord::Migration[5.2]
  def change
    rename_column :rooms, :img, :image
  end
end
