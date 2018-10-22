class Admin::UsersController < ApplicationController
  
  before_action :admin_user_true?
  
  def active
    users = User.all
    @users = []
    users.each do |user|
      if user.attendances.find_by(day: Date.today).arrival && user.attendances.find_by(day: Date.today).leave.nil?
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
