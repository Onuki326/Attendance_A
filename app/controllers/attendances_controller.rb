class AttendancesController < ApplicationController
  
   before_action :redirect_admin
   
  def modal
    @user = User.find(params[:user_id])
    @aploy = Aploy.new
    @aploys = Aploy.where(sperior_id: @user, state: "申請中")
    @users = []
    @aploys.each do |user|
        aploy_user = User.find(user.user_id)
      if not @users.include?(aploy_user)
        @users.push(aploy_user)
      end
    end
  end
  
  def check
    @user = User.find(params[:user_id])
    @date = params[:day].to_date
    @hours = []
    @hour = []
    @day = []
    @beginning_date = @date.beginning_of_month
    @end_date = @date.end_of_month
    (@beginning_date..@end_date).each do |date|
      @day.push(date)
      if @user.attendances.find_by(day: date)
        @hour.push(@user.attendances.find_by(day: date))
      end
      if @user.normal_arrival(date).present? && @user.normal_leave(date).present?
        @duty_hour = ((@user.normal_leave(date)) - (@user.normal_arrival(date))) / 3600
        @duty_hour = sprintf("%.2f", @duty_hour)
        @hours.push(@duty_hour.to_f)
      end
    end
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end  
  
  def create
    @user = User.find_by(id: params[:user_id])
    @attendance = @user.attendances.find_by(day: params[:day])
    if @attendance.arrival.nil?
      attendance = @user.attendances.find_by(day: params[:day])
      attendance.arrival = DateTime.now.change(sec: 00)
      attendance.save
    elsif @attendance.leave.nil?
      attendance = @user.attendances.find_by(day: params[:day])
      attendance.leave = DateTime.now.change(sec: 00)
      attendance.save
    end
    redirect_to @user
  end
  
  def update
    @user = User.find(params[:user_id])
    @user.update_attributes(normal_params)
    redirect_to @user
  end
  
    private
  
      def normal_params
        params.permit([normal: [:day, :arrival, :leave, :sperior_id, :user_id]])
      end
end
