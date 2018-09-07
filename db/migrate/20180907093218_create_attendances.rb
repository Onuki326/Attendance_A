class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.datetime :day
      t.datetime :arrival
      t.datetime :leave
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
