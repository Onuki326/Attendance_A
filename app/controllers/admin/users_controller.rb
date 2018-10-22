class Admin::UsersController < ApplicationController
  
  before_action :admin_user_true?
  
  def active
    users = User.all
    @users = []
    users.each do |user|
    attendance = Attendance.find_by(user_id: user, day: Date.today)
      if attendance&.arrival && attendance&.leave.nil?
        @users.push(user)
      end 
    end  
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def basictime
    @user = User.find(params[:id])
  end
  
end
