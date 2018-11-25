class AddYearmonthToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :year_month, :string
  end
end
