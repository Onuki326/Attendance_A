class AttendancesController < ApplicationController
  before_action :correct_user,     only: [:edit]
  
  def create
    @user = User.find_by(id: params[:attendance][:user_id])
    @attendance = @user.attendances.find_by(day: params[:attendance][:day])
    if @attendance.arrival.nil?
      attendance = @user.attendances.find_by(day: params[:attendance][:day])
      attendance.arrival = DateTime.now.change(sec: 00)
      attendance.save
    elsif @attendance.leave.nil?
      attendance = @user.attendances.find_by(day: params[:attendance][:day])
      attendance.leave = DateTime.now.change(sec: 00)
      attendance.save
    end
    #byebug
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
  
    private
  
      def attendances_params
        params.require(:user).permit(attendances_attributes: [:day, :arrival, :leave, :_destroy, :id])
      end
      
  # beforeアクション
  
  def admin_user_and_correct_user
    if admin_user?
      @user = User.find(params[:id])
    elsif 
      @user = User.find(params[:id])
    else
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end  
end
