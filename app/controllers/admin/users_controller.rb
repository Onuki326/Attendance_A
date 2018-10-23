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
  
  def create
    User.import(params[:csv_file])
    redirect_to admin_users_url
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(admin_user_params)
      flash[:success] = "編集しました"
      redirect_to admin_users_url
    else
      render admin_users
    end  
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to asmin_users_url
  end  
  
  def basictime
    @user = User.find(params[:id])
  end
  
    private
    
    def admin_user_params
      params.require(:user).permit(:name, 
                                     :email,
                                     :affiliation,
                                     :password,
                                     :password_confirmation,
                                     :employee_number,
                                     :employee_id,
                                     :basic_working_hours,
                                     :starting_work_at,
                                     :finishing_work_at)
    end                                 
  
end
