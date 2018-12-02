require 'csv'
  CSV.generate do |csv|
    column_names = [
      "id", 
      "name",
      "email",
      "password",
      "admin",
      "affiliation",
      "employee_number",
      "employee_id",
      "basic_working_hours",
      "starting_work_at",
      "finishing_work_at",
      "sperior"
    ]
    csv << column_names
    @users.each do |user|
      column_values = [
        user.id, 
        user.name, 
        user.email,
        user.password,
        user.admin,
        user.affiliation,
        user.employee_number,
        user.employee_id,
        user.basic_working_hours,
        user.starting_work_at,
        user.finishing_work_at,
        user.sperior
      ]
      csv << column_values   
    end
  end  