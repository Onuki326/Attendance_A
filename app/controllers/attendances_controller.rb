class AttendancesController < ApplicationController
  before_action :attendance_correct_user,     only: [:edit]
  
  def create
    @user = User.find_by(id: params[:user_id])
    @attendance = @user.attendances.find_by(day: params[:day])
    if @attendance.arrival.nil?
      @attendance.arrival = DateTime.now.change(sec: 00)
      @attendance.save
    elsif @attendance.leave.nil?
      @attendance.leave = DateTime.now.change(sec: 00)
      @attendance.save
    end
    redirect_to @user
  end
  
  def edit
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.build
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
    @user = User.find(params[:user_id])
    @user.update_attributes(attendance_params)
    redirect_to @user
  end
  
    private
  
      def attendance_params
        params.require(:user).permit(attendances_attributes: [:id, :arrival, :leave])
      end
      
  # beforeアクション
  
  def attendance_correct_user
    if not admin_user?
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
  
end
