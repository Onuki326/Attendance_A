class ChangeDatetypeDayOfAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :day, :date
  end
end
