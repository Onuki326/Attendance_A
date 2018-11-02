class AddRemarkToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :remark, :text
  end
end