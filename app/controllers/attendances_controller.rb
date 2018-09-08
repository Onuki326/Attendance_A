class AttendancesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  
  def create
    @attendance = current_user.attendances.build(attendance_params)
    @attendance.save
    redirect_to user_path(current_user.id)
  end
  
  private
  
    def attendance_params
      params.require(:attendance).permit(:arrival, :leave)
    end  
end
