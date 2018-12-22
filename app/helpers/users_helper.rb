module UsersHelper
  
  # 出社時間(時)
  def arrival_hour(d)
    @a_hour = @user.normal_arrival(d)
    if not @a_hour.nil?
      @a_hour = @a_hour.strftime("%H")
    end
  end
  
  # 出社時間(分)
  def arrival_min(d)
    @a_min = @user.normal_arrival(d)
    if not @a_min.nil?
      @a_min = @a_min.strftime("%M")
    end
  end
  
  # 退社時間(時)
  def leave_hour(d)
    @l_hour = @user.normal_leave(d)
    if not @l_hour.nil?
      @l_hour = @l_hour.strftime("%H")
    end
  end
  
  # 退社時間(分)
  def leave_min(d)
    @l_min = @user.normal_leave(d)
    if not @l_min.nil?
      @l_min = @l_min.strftime("%M")
    end
  end
  
  # 在社時間(退勤時間-出社時間)
  def duty_hour(d)
    if @user.normal_arrival(d).present? && @user.normal_leave(d).present?
      @duty_hour = ((@user.normal_leave(d)) - (@user.normal_arrival(d))) / 3600
      @duty_hour = sprintf("%.2f", @duty_hour)
    end
  end
  
  # 勤務日数
  def attendance_days
    @hours.length
  end  
  
  # 合計勤務時間
  def total_hour
    @t_hour = @hours.sum
    @t_hour = sprintf("%.2f", @t_hour)
  end
  
  # 指定勤務開始時間
  def starting_hour
    @sh = @user.starting_work_at
    if @sh.nil?
      @sh = 0.00
      @sh = sprintf("%.2f", @sh)
    else  
      h = @sh.strftime("%H").to_i
      m = @sh.strftime("%M").to_f / 60
      s = h + m
      s = sprintf("%.2f", s)
    end  
  end
  
  # 指定勤務終了時間
  def finishing_hour
    @fh = @user.finishing_work_at
    if @fh.nil?
      @fh = 0.00
      @fh = sprintf("%.2f", @fh)
    else  
      h = @fh.strftime("%H").to_i
      m = @fh.strftime("%M").to_f / 60
      s = h + m
      s = sprintf("%.2f", s)
    end
  end  
  
  # 基本時間
  def basic_working_hour
    @basic_working_hours = @user.basic_working_hours
    if @basic_working_hours.nil?
      @basic_working_hours = 0.00
      @basic_working_hours = sprintf("%.2f", @basic_working_hours)
    else  
      h = @basic_working_hours.strftime("%H").to_i
      m = @basic_working_hours.strftime("%M").to_f / 60
      s = h + m
      s = sprintf("%.2f", s)
    end
  end
  
  # 基本時間合計
  def basic_total_hour
    @basic_total_hour = basic_working_hour.to_f * @hours.length
    @basic_total_hour = sprintf("%.2f", @basic_total_hour)
  end
  
  # 申請状況表示
  def apploy_state(day)
    @user.revise_applications.find_by(day: day)&.state
  end  
  # 残業申請stateを取得
  def overtime_state(user, day)
    user.overtime_applications.find_by(day: day)&.state
  end
  
  # 勤怠編集stateを取得
  def normal_state(user, day)
    user.normal_applications.find_by(day: day)&.state
  end
  
  # 時間外時間取得
  def overtime_at(user, date)
    finish = user.overtime_applications.find_by(day: date).finish_at
    standard = user.finishing_work_at.change(day: date.day)
    overtime = (finish - standard)/3600
    overtime = sprintf("%.2f", overtime)
  end
  
  # 申請年月の取得
  def aproy_day(day)
    day_year = day.year
    day_month = day.month
    aploy_date = "#{day_year}-#{day_month}"
  end
  
  # 上長からの申請結果の表示
  def aploy_to_user(day, user)
    aploy_date = aproy_day(day)
    user_aploy = user.aploys.find_by(day: aploy_date)
    if not user_aploy.nil?
      sperior = User.find_by(id: user_aploy.sperior_id).name
      if user_aploy.state == "申請中"
        "上長#{sperior}から承認待ち"
      elsif user_aploy.state == "承認"
        "上長#{sperior}から承認済み"
      elsif user_aploy.state == "否認"
        "上長#{sperior}から否認"
      end
    end  
  end
  
  # 申請ログattendanceを探す
  def approval_attendance_data(attendance)
    approval = @user.approval_attendances.find_by(day: attendance.day)
  end
  
  # 変更前出社時間(時)
  def approval_arrival_hour(attendance)
    approval = @user.approval_attendances.find_by(day: attendance.day)
    approval.arrival.strftime("%H") if approval.arrival != nil
  end
  
  # 変更前出社時間(分)
  def approval_arrival_min(attendance)
    approval = @user.approval_attendances.find_by(day: attendance.day)
    approval.arrival.strftime("%M") if approval.arrival != nil
  end
  
  # 変更前退社時間(時)
  def approval_leave_hour(attendance)
    approval = @user.approval_attendances.find_by(day: attendance.day)
    approval.leave.strftime("%H") if approval.leave != nil
  end
  
  # 変更前退社時間(分)
  def approval_leave_min(attendance)
    approval = @user.approval_attendances.find_by(day: attendance.day)
    approval.leave.strftime("%M") if approval.leave != nil
  end
  
  # 変更前在社時間
  def living_at(attendance)
    approval = @user.approval_attendances.find_by(day: attendance.day)
    ((approval.leave-approval.arrival)/3600).floor(2).to_f if approval.leave != nil && approval.arrival != nil
  end
  
  # CSV用在社時間時間
  def csv_attendance(attendance)
    if attendance.arrival.present? && attendance.leave.present?
      ((attendance.leave-attendance.arrival)/3600).floor(2).to_f
    end
  end
  
end