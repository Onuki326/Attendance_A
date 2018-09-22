class AttendancesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  
  def create
    @user = User.find_by(id: params[:attendance][:user_id])
    @attendance = @user.attendances.find_by(day: params[:attendance][:day])
    if @attendance.arrival.nil?
      attendance = @user.attendances.find_by(day: params[:attendance][:day])
      attendance.arrival = params[:attendance][:arrival]
      attendance.save
    elsif @attendance.leave.nil?
      attendance = @user.attendances.find_by(day: params[:attendance][:day])
      attendance.leave = params[:attendance][:leave]
      attendance.save
    end
    redirect_to @user
  end
  
  def edit
    @user = User.new(id: params[:id])
    @user.attendances.build
    @date = params[:date]
    @date = @date.to_datetime
    @d = []
    @fd = @date.beginning_of_month
    @ed = @date.end_of_month
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
    (@fd..@ed).each do |i|
      @d.push(i)
    end
  end
  
  def update
    @attendance = Attendance.find_by(params[:id])
    @attendance.save
    redirect_to @user
  end
  
    private
  
      def attendance_params
        params.require(:attendance).permit(:day, :arrival, :leave)
      end
end
