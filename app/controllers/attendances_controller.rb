class AttendancesController < ApplicationController
  before_action :attendance_correct_user,     only: [:edit]
  
  
  def edit
    @user = User.find(params[:user_id])
    @attendance = Revise.new
    #@attendance = @user.normal_applications.build
    @date = params[:date]
    @date = @date.to_datetime
    @d = []
    @fd = @date.beginning_of_month
    @ed = @date.end_of_month
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
    (@fd..@ed).each do |i|
      @d.push(i)
    end
    # 上長ユーザーの取得
      @sperior_users = User.where(sperior: true)
  end
  
  def update
    @user = User.find(params[:user_id])
    @user.update_attributes(normal_params)
    #binding.pry
    #@user.passive_relationships.find_by(requester_id: ).destroy ユーザーの申請を取り消す
    redirect_to @user
  end
  
  def approval
    
  end  
  
  def revise
    @user = User.find_by(id: params[:user_id])
    @fd = DateTime.now.beginning_of_month
    @ed = @fd.end_of_month
    (@fd..@ed).each do |i|
      if @revise = @user.normal_applications.find_buy(day: i)
        @revice = Revise.new(revice_params)
      end 
    redirect_to @user  
    end
  end
  
  def create
    @user = User.find_by(id: params[:user_id])
    binding.pry
    #if @attendance.arrival.nil?
    #  @attendance.arrival = DateTime.now.change(sec: 00)
    #  @attendance.save
    #elsif @attendance.leave.nil?
    #  @attendance.leave = DateTime.now.change(sec: 00)
    #  @attendance.save
    #end
    redirect_to @user
  end
  
    private
  
      def revice_params
        params.require(:user).permit(revise_applications_attributes: [:user_id, :id, :arrival, :leave, :sperior_id, :type])
      end
      
  # beforeアクション
  
  def attendance_correct_user
    if not admin_user?
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
  
end
