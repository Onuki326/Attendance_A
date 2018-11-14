class OvertimesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @overtime = Overtime.new(user_id: @user.id, day: params[:day])
    @sperior_users = User.where(sperior: true)
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
  end

  def create
  end

  def update
  end
end
