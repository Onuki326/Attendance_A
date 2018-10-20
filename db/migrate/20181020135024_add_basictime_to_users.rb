class AddBasictimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :basic_working_hours, :datetime
    add_column :users, :starting_work_at, :datetime
    add_column :users, :finishing_work_at, :datetime
  end
end
