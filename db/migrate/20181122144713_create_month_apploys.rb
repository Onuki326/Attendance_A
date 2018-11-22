class CreateMonthApploys < ActiveRecord::Migration[5.1]
  def change
    create_table :month_apploys do |t|
      t.intger :user_id
      t.integer :date_id

      t.timestamps
    end
  end
end
