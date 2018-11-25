class CreateAploys < ActiveRecord::Migration[5.1]
  def change
    create_table :aploys do |t|
      t.string :day

      t.timestamps
    end
  end
end
