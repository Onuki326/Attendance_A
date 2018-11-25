class AttendancesController < ApplicationController
  #before_action :attendance_correct_user,     only: [:edit]
  
  
  #def edit
  # @user = User.find(params[:user_id])
  #  @attendance = Revise.new
  #  #@attendance = @user.normal_applications.build
  #  @date = params[:date]
  #  @date = @date.to_datetime
  #  @d = []
  #  @fd = @date.beginning_of_month
  #  @ed = @date.end_of_month
  #  @wd = ["日", "月", "火", "水", "木", "金", "土"]
  #  (@fd..@ed).each do |i|
  #    @d.push(i)
  #  end
    # 上長ユーザーの取得
  #    @sperior_users = User.where(sperior: true)
  #end
  
  def update
    binding.pry
    @user = User.find(params[:user_id])
    @user.update_attributes(normal_params)
    #@user.passive_relationships.find_by(requester_id: ).destroy ユーザーの申請を取り消す
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
    binding.pry
  end
  
  def create
    binding.pry
  #  @user = User.find_by(id: params[:user_id])
  #  @revises = []
  #  @revises = revise_params
  #  @revises[:revise_applications_attributes].each do |i|
  #    @revise = Revise.new(@revises[:revise_applications_attributes][:"#{i}"])
  #    @sperior = User.find_by(id: @revise.sperior_id)
  #    if @revise.sperior_id.present? && !@user.requesting?(@sperior)
  #      @user.approy(@sperior)
  #      day = @revise.day.mday
  #      @revise.arrival&.change(day: day)
  #      @revise.leave&.change(day: day)
  #      @revise.save
  #    elsif @revise.sperior_id.present? && @user.requesting?(@sperior)
  #      day = @revise.day.mday
  #      @revise.arrival&.change(day: day)
  #      @revise.leave&.change(day: day)
  #      @revise.save
  #    end
  #  end
  #  redirect_to @user
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
