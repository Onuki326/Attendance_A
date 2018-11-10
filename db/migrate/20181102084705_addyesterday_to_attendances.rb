class AddyesterdayToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :yesterday_state, :boolean, default: false
  end
end
