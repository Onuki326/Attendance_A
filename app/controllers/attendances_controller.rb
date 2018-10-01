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
    @user = User.find(params[:id])
    @attendance = @user.attendances.build(id: @user.id)
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
    #byebug
    @user = User.find(params[:id])
    @user.update_attributes(attendances_params)
    redirect_to @user
  end
  
  def basic_time
    
  end  
  
    private
  
      def attendances_params
        params.require(:user).permit(attendances_attributes: [:day, :arrival, :leave, :_destroy, :id])
      end
      
end
