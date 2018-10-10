class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user_true?,     only: [:destroy, :index]
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
   
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
      if not @user.attendances.any? { |obj| obj.day == i }
        attendance = Attendance.new(user_id: @user.id, day: i)
        attendance.save
      end
      # 在社時間
      if @user.attendances.find_by(day: i).arrival && @user.attendances.find_by(day: i).leave
        @duty_hour = (@user.attendances.find_by(day: i).leave - @user.attendances.find_by(day: i).arrival) / 3600
        @duty_hour = sprintf("%.2f", @duty_hour)
        @hours.push(@duty_hour.to_f)
      end
    end
    
    # 在社時間と出勤日数
    #@d.each do |d|
     # if @user.attendances.find_by(day: d).arrival && @user.attendances.find_by(day: d).leave
     #  a = (@user.attendances.find_by(day: d).leave - @user.attendances.find_by(day: d).arrival) / 3600
     #  a = sprintf("%.2f", a).to_f
     #  @hours.push(a)
    # end
    #end
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
  
  private
    def user_params
      params.require(:user).permit(:name, 
                                   :email,
                                   :affiliation,
                                   :password,
                                   :password_confirmation)
    end
    
end