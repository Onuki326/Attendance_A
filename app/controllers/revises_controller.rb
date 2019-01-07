class RevisesController < ApplicationController
  
  before_action :redirect_admin
  
  def modal
    @user = User.find(params[:user_id])
    @users = []
    @user.requesters.each do |i|
      @users.push(i)
    end
    @applications = Revise.where(sperior_id: @user.id)
    @attendance = Attendance.new(sperior_id: @user.id)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end
  
  def new
    @user = User.find(params[:user_id])
    @attendance = Revise.new
    # 上長ユーザーの取得
    @sperior_users = User.where(sperior: true)
    @sperior_users = @sperior_users.where.not(id: @user.id)
    @sperior = @sperior_users.map{|t| [t.name, t.id]}
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
    @attendances = []
    @sperior_users = User.where(sperior: true).where.not(id: @user.id)
    @sperior = @sperior_users.map{|t| [t.name, t.id]}
    @revises = revise_params
    @date = params[:date]
    @date = @date.to_datetime
    @d = []
    @fd = @date.beginning_of_month
    @ed = @date.end_of_month
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
    (@fd..@ed).each do |i|
      @d.push(i)
    end
    @error_count = 0
    @success_count = 0
    @revises[:revise_applications_attributes].each do |i|
      @revise = Revise.new(@revises[:revise_applications_attributes][:"#{i}"])
      if @revise.sperior_id.present?
        @day = @revise.day.mday
        if @revise.arrival != nil && @revise.leave  != nil && check_time(@revise)
          if @revise.yesterday_state == true
            #@revise.arrival = @revise.arrival&.change(day: @day)
            #@revise.leave = @revise.leave&.change(day: @day)
            #@revise.leave = @revise.leave.tomorrow
          else
            #@revise.arrival = @revise.arrival&.change(day: @day)
            #@revise.leave = @revise.leave&.change(day: @day)
          end
          @attendances.push(@revise)
          @user.approy(User.find(@revise.sperior_id)) if !@user.requesting?(User.find(@revise.sperior_id))
        else
          @error_count += 1
          @error_revise = @revises[:revise_applications_attributes][:"#{i}"]
        end
      end
    end
    if @error_count > 0
      flash.now[:danger] = "#{@error_count}件の入力ミスがあります"
      render "new"
    elsif @attendances.present? && @error_count == 0
      @attendances.each do |attendance|
        revise = attendance
        revise.save
        @success_count += 1
      end
      flash[:success] = "#{@success_count}件の勤怠変更を申請しました"
      redirect_to @user
    else
      flash[:danger] = "上長の指定がありません"
      render "new"
    end
  end
  
    private
    
      def revise_params
        params.require(:user).permit(revise_applications_attributes: [:day, 
                                                                      :user_id, 
                                                                      :arrival, 
                                                                      :leave, 
                                                                      :sperior_id, 
                                                                      :type, 
                                                                      :remark, 
                                                                      :state, 
                                                                      yesterday_state: []])
      end
      
      def check_time(revise)
        if revise.yesterday_state == true
          revise.arrival = revise.arrival&.change(day: revise.day.day)
          revise.leave = revise.leave&.change(day: revise.day.day)
          revise.leave = revise.leave.tomorrow
          revise.arrival < revise.leave
        else
          revise.arrival = revise.arrival&.change(day: revise.day.day)
          revise.leave = revise.leave&.change(day: revise.day.day)
          revise.arrival < revise.leave
        end
      end
end