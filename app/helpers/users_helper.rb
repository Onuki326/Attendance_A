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
  
end