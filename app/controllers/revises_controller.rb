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
        if @revise.yesterday == true
          
          @revise.leave = @revise.leave.tomorrow
        end  
        @revise.save
      elsif @revise.sperior_id.present? && @user.requesting?(@sperior)
        if @revise.yesterday == true
          
          @revise.leave = @revise.leave.tomorrow
        end  
        @revise.save
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
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end
  
    private
  
      def revise_params
        params.require(:user).permit(revise_applications_attributes: [:day, :user_id, :arrival, :leave, 
                                                                      :sperior_id, :type, :yesterday, :remark])
      end

end