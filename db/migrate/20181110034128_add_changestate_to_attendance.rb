class AddChangestateToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :change_state, :boolean, default: false
  end
end
