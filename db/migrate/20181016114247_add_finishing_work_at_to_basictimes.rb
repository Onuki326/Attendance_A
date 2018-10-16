class AddFinishingWorkAtToBasictimes < ActiveRecord::Migration[5.1]
  def change
    add_column :basictimes, :finishing_work_at, :datetime
  end
end
