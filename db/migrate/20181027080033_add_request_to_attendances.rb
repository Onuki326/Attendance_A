class AddRequestToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :sperior_id, :string
    add_column :attendances, :type, :string
  end
end