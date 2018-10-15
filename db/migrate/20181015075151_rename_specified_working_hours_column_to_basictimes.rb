class RenameSpecifiedWorkingHoursColumnToBasictimes < ActiveRecord::Migration[5.1]
  def change
    rename_column :basictimes, :specified_working_hours, :starting_work_at
  end
end
