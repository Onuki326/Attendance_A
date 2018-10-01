class CreateBasictimes < ActiveRecord::Migration[5.1]
  def change
    create_table :basictimes do |t|
      t.datetime :basic_working_hours
      t.datetime :specified_working_hours

      t.timestamps
    end
  end
end
