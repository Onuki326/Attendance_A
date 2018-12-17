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
    @sperior_users = User.where(sperior: true)
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
    @succes_count = 0
    @revises[:revise_applications_attributes].each do |i|
      #if @user.normal_applications.find_by(day: @revises[:revise_applications_attributes][:"#{i}"][:day]).arrival != nil && @user.normal_applications.find_by(day: @revises[:revise_applications_attributes][:"#{i}"][:day]).leave != nil
         # binding.pry
        @revise = Revise.new(@revises[:revise_applications_attributes][:"#{i}"])
      #end
      if @user.normal_applications.find_by(day: @revise.day).arrival != nil && @user.normal_applications.find_by(day: @revise.day).leave != nil
        if @revise.sperior_id.present? && @revise.arrival != nil && @revise.leave != nil
          @sperior = User.find_by(id: @revise.sperior_id)
          @day = @revise.day.mday
          if !@user.requesting?(@sperior)
            @user.approy(@sperior)
          end
            binding.pry
          if @revise.yesterday_state == true
            @revise.arrival = @revise.arrival&.change(day: @day)
            @revise.leave = @revise.leave&.change(day: @day)
            @revise.leave = @revise.leave.tomorrow
          else
            @revise.arrival = @revise.arrival&.change(day: @day)
            @revise.leave = @revise.leave&.change(day: @day)
          end
          
            #if @revise.yesterday_state == "true"
            #  @revise.arrival = @revise.arrival&.change(day: @day)
            #  @revise.leave = @revise.leave&.change(day: @day)
            #  @revise.leave = @revise.leave.tomorrow
            #else
            #  @revise.arrival = @revise.arrival&.change(day: @day)
            #  @revise.leave = @revise.leave&.change(day: @day)
            #end
          @attendances.push(@revise)
        end  
      elsif @revise.sperior_id.present? || @revise.arrival.present? || @revise.leave.present?
        @error_count += 1
        @error_revise = @revises[:revise_applications_attributes][:"#{i}"]
      end
    end
    if not @error_count > 0
      @attendances.each do |attendance|
        attendance = attendance
        attendance.save
        @succes_count += 1
      end
      flash[:sacces] = "#{@succes_count}件登録しました"
      redirect_to @user
    else
      flash.now[:danger] = "#{@error_count}件の入力ミスがあります"
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
end