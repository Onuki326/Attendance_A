class AttendancesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  
  def create
    @user = User.find_by(id: params[:attendance][:user_id])
    #if current_user.attendances.find_by(para: day)
    @attendance = current_user.attendances.build(attendance_params)
    @attendance.save
    redirect_to @user
  end
  
  private
  
    def attendance_params
      params.require(:attendance).permit(:day, :arrival, :leave)
    end
end
