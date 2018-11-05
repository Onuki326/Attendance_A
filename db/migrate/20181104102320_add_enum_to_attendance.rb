class AddEnumToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :state, :integer, default: "なし"
  end
end
