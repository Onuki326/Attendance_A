class OvertimesController < ApplicationController
  
  before_action :redirect_admin
  
  def show
    @user = User.find(params[:user_id])
    @users = []
    @user.requesters.each do |user|
      if user.overtime_applications.present?
        @users.push(user)
      end
    end
    @applications = Overtime.where(sperior_id: @user.id, state: "申請中")
    @overtime = Attendance.new(sperior_id: @user.id)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end
  
  def new
    @user = User.find(params[:user_id])
    @overtime = Attendance.new(user_id: @user.id, day: params[:day])
    # 上長ユーザーの取得
    @sperior_users = User.where(sperior: true).where.not(id: @user.id)
    @sperior = @sperior_users.map{|t| [t.name, t.id]}
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def create
    @user = User.find(params[:user_id])
    @overtime = @user.overtime_applications.new(overtime_params[:overtime].first)
    @day = @overtime.day.mday
    @overtime.finish_at = @overtime.finish_at.change(day: @day)
    if @overtime.sperior_id.present?
      if @overtime.yesterday_state == true
        @overtime.finish_at = @overtime.finish_at.tomorrow
      end
      if @user.active_relationships.blank? && @overtime.present?
        @user.approy(User.find_by(id: @overtime.sperior_id))
      end
      @overtime.save
    end
    redirect_to @user
  end

  def update
    @user = User.find(params[:user_id])
    overtime_params[:overtime].each do |overtime|
      @appliant = User.find_by(id: overtime[:user_id])
      if overtime[:change_state].present? && overtime[:state].in?(["申請中","承認","否認"])
        @overtime = Overtime.find_by(user_id: overtime[:user_id], day: overtime[:day])
        @overtime.update(overtime)
      end
      if @appliant.revise_applications.where(state: "申請中").blank? && @appliant.overtime_applications.where(state: "申請中").blank?
        @appliant.active_relationships.find_by(requested_id: @user).destroy
      end
    end
    redirect_to @user
  end
  
    private
      def overtime_params
        params.permit(overtime: [:user_id, :finish_at, :day, :sperior_id, :remark, :yesterday_state, :state, change_state: []])
      end
end