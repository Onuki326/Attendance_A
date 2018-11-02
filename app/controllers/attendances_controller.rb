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
  
  def create
    @user = User.find_by(id: params[:user_id])
    @revises = []
    @revises = revise_params
    @revises[:revise_applications_attributes].each do |i|
      @revise = Revise.new(@revises[:revise_applications_attributes][:"#{i}"])
      @sperior = User.find_by(id: @revise.sperior_id)
      if @revise.sperior_id.present? && !@user.requesting?(@sperior)
        @user.approy(@sperior)
        day = @revise.day.mday
        #binding.pry
        @revise.arrival&.change(day: day)
        @revise.leave&.change(day: day)
        @revise.save
      elsif @revise.sperior_id.present? && @user.requesting?(@sperior)
        day = @revise.day.mday
        #binding.pry
        @revise.arrival&.change(day: day)
        @revise.leave&.change(day: day)
        @revise.save
      end
    end
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
  
      def revise_params
        params.require(:user).permit(revise_applications_attributes: [:day, :user_id, :arrival, :leave, :sperior_id, :type])
      end
      
     
  # beforeアクション
  
  def attendance_correct_user
    if not admin_user?
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
  
end
