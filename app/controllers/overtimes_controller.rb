class OvertimesController < ApplicationController
  
  def show
    @user = User.find(params[:user_id])
    @users = []
    @user.requesters.each do |user|
      if user.overtime_applications.present?
        @users.push(user)
      end
    end
    @applications = Overtime.where(sperior_id: @user.id)
    @overtime = Attendance.new(sperior_id: @user.id)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end
  
  def new
    @user = User.find(params[:user_id])
    @overtime = Overtime.new(user_id: @user.id, day: params[:day])
    @sperior_users = User.where(sperior: true)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def create
    @user = User.find(params[:user_id])
    @overtime = @user.overtime_applications.new(overtime_params)
    @day = @overtime.day.mday
    @overtime.finish_at = @overtime.finish_at.change(day: @day)
    if @overtime.sperior_id == present?
      if @overtime.yesterday_state == true
        @overtime.finish_at = @overtime.finish_at.tomorrow
      end
    end
    @overtime.save
    redirect_to @user
  end

  def update
    @user = User.find(params[:user_id])
    overtime_params[:overtime].each do |overtime|
      if not overtime[:change_state].blank?
        @overtime = Overtime.find_by(user_id: overtime[:user_id], day: overtime[:day])
        @overtime.update(overtime)
      end
    end
    redirect_to @user
  end
  
    private
      def overtime_params
        params.permit(overtime: [:user_id, :finish_at, :day, :sperior_id, :remark, :yesterday_state, :state, change_state: []])
      end  
end
