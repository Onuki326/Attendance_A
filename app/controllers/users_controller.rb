class UsersController < ApplicationController
  
  before_action :redirect_admin,   only: [:show]
  before_action :correct_user,     only: [:show, :edit, :update]
  before_action :logged_in_user,   only: [:edit, :update, :destroy]
  before_action :admin_user_true?, only: [:destroy, :index]
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to users_url
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @aploy = Aploy.new
    # 日付の取得、変更
    if params[:date]
      @date = params[:date]
      @date = @date.to_datetime
    else
      @date = Date.today
    end
   
    #　該当する月の日付と曜日と勤怠インスタンスを作成
    @fd = @date.beginning_of_month
    @ed = @date.end_of_month
    @d = []
    @w = []
    @hours = []
    @wd = ["日", "月", "火", "水", "木", "金", "土"]
    (@fd..@ed).each do |i|
      @d.push(i)
      if not @user.normal_applications.any?{ |n| n.day == i }
        attendance = Normal.new(user_id: @user.id, day: i)
        attendance.save
      end
      # 在社時間
      if @user.normal_arrival(i).present? && @user.normal_leave(i).present?
        @duty_hour = ((@user.normal_leave(i)) - (@user.normal_arrival(i))) / 3600
        @duty_hour = sprintf("%.2f", @duty_hour)
        @hours.push(@duty_hour.to_f)
      end
      # 上長ユーザーの取得
      @sperior_users = User.where(sperior: true).where.not(id: @user.id)
      @sperior = @sperior_users.map{|t| [t.name, t.id]}
      # 編集申請お知らせ(revise,overtime)
      @revise_aploy = []
      @overtime_aploy = []
      @user.requesters.each do |user|
        if user.revise_applications.present?
          user.revise_applications.each do |revise|
            @revise_aploy.push(revise)
          end
        end
        if user.overtime_applications.where(state: "申請中").present?
          user.overtime_applications.each do |overtime|
            if overtime.state == "申請中"
              @overtime_aploy.push(overtime)
            end
          end
        end
      end
      # 編集申請お知らせ(aploy)
      @aploys = []
      Aploy.where(sperior_id: @user.id).each do |aploy|
        if aploy.state == "申請中"
          @aploys.push(aploy)
        end
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "アカウントを更新しました"
      # 更新に成功した場合を扱う。
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # 保存の成功をここで扱う。
      flash[:success] = "登録できました"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def csv_output
    @user = User.find(params[:user_id])
    @date = params[:date]
    @date = @date.to_datetime
    @week = ["日", "月", "火", "水", "木", "金", "土"]
    @fd = @date.beginning_of_month
    @ed = @date.end_of_month
    @attendances = []
    (@fd..@ed).each do |i|
      attendance = @user.normal_applications.find_by(day: i)
      @attendances.push(attendance)
    end
    respond_to do |format|
      format.csv do
        send_data(render_to_string, {filename: "#{@user.name}#{@date.month}月分勤怠一覧.csv", type: 'text/csv; charset=shift_jis'})
      end
    end
  end
  
  def revise_log
    @user = User.find(params[:user_id])
    @date = params[:date]
    @date = @date.to_datetime
    @week = ["日", "月", "火", "水", "木", "金", "土"]
    @fd = @date.beginning_of_month
    @ed = @date.end_of_month
    @attendances = []
    (@fd..@ed).each do |date|
      attendance = @user.normal_applications.find_by(day: date)
        @attendances.push(attendance) if attendance.state == "承認" 
      end  
  end
  
  private
    def user_params
      params.require(:user).permit(:name, 
                                   :email,
                                   :affiliation,
                                   :password,
                                   :password_confirmation,
                                   :employee_number,
                                   :employee_id,
                                   :basic_working_hours,
                                   :starting_work_at,
                                   :finishing_work_at)
    end
    
end