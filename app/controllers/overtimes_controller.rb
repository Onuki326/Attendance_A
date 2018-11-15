class OvertimesController < ApplicationController
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
  end
  
    private
      def overtime_params
        params.require(:overtime).permit(:finish_at, :day, :sperior_id, :remark, :yesterday_state, :state)
      end  
end
