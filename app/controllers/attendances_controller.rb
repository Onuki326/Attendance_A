class AttendancesController < ApplicationController
  
  def update
    @user = User.find(params[:user_id])
    @user.update_attributes(normal_params)
    redirect_to @user
  end
  
  def modal
    @user = User.find(params[:user_id])
    @aploy = Aploy.new
    @aploys = Aploy.where(sperior_id: @user)
    @users = []
    @aploys.each do |user|
        aploy_user = User.find(user.user_id)
      if not @users.include?(aploy_user)
        @users.push(aploy_user)
      end
    end
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
  
    private
  
      def normal_params
        params.permit([normal: [:day, :arrival, :leave, :sperior_id, :user_id]])
      end
     
  # beforeアクション
  
  def attendance_correct_user
    if not admin_user?
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
  
end
