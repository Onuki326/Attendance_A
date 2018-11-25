class AddDateapolyToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :aploy_date, :string
  end
end