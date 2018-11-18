class RevisesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @attendance = Revise.new
    # 上長ユーザーの取得
    @sperior_users = User.where(sperior: true)
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

  def create
    @user = User.find_by(id: params[:user_id])
    @revises = []
    @revises = revise_params
    @revises[:revise_applications_attributes].each do |i|
      @revise = Revise.new(@revises[:revise_applications_attributes][:"#{i}"])
      @sperior = User.find_by(id: @revise.sperior_id)
      if @revise.sperior_id.present? && !@user.requesting?(@sperior)
        @user.approy(@sperior)
        @day = @revise.day.mday
        if @revise.yesterday_state == "true"
          @revise.arrival = @revise.arrival&.change(day: @day)
          @revise.leave = @revise.leave&.change(day: @day)
          @revise.leave = @revise.leave.tomorrow
          binding.pry
        else
          @revise.arrival = @revise.arrival&.change(day: @day)
          @revise.leave = @revise.leave&.change(day: @day)
        end
      elsif @revise.sperior_id.present? && @user.requesting?(@sperior)
        if @revise.yesterday_state == "true"
          @revise.arrival = @revise.arrival&.change(day: @day)
          @revise.leave = @revise.leave&.change(day: @day)
          @revise.leave = @revise.leave.tomorrow
        else
          @revise.arrival = @revise.arrival&.change(day: @day)
          @revise.leave = @revise.leave&.change(day: @day)
        end
      end
      if @revise.save
        @normal = @user.normal_applications.find_by(day: @revise.day)
        @normal.state = "申請中"
        @normal.save
      end
    end
    redirect_to @user
  end
  
  def modal
    @user = User.find(params[:user_id])
    @users = []
    @user.requesters.each do |i|
      @users.push(i)
    end
    #binding.pry
    @applications = Revise.where(sperior_id: @user.id)
    @attendance = Attendance.new(sperior_id: @user.id)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end
  
    private
  
      def revise_params
        params.require(:user).permit(revise_applications_attributes: [:day, :user_id, :arrival, 
                                                                      :leave, :sperior_id, :type, 
                                                                      :remark, :state, yesterday_state: []])
      end

end