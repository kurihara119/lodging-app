class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :number_people
      t.date :start_day
      t.date :end_day
      t.integer :stay_day
      t.integer :total_amount

      t.timestamps
    end
  end
end
