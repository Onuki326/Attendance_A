class AddDateIdToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :date_id, :integer
  end
end
