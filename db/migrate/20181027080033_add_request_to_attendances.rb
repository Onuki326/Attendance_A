class AddRequestToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :request_id, :string
  end
end
