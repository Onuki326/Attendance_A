module UsersHelper
  
  # 出社時間(時)
  def arrival_hour(d)
    @a_hour = @user.attendances.find_by(day: d)
    if not @a_hour.arrival.nil?
      @a_hour = @a_hour.arrival.strftime("%H")
    end
  end
  
  # 出社時間(分)
  def arrival_min(d)
    @a_min = @user.attendances.find_by(day: d)
    if not @a_min.arrival.nil?
      @a_min = @a_min.arrival.strftime("%M")
    end
  end
  
  # 退社時間(時)
  def leave_hour(d)
    @l_hour = @user.attendances.find_by(day: d)
    if not @l_hour.leave.nil?
      @l_hour = @l_hour.leave.strftime("%H")
    end
  end
  
  # 退社時間(分)
  def leave_min(d)
    @l_min = @user.attendances.find_by(day: d)
    if not @l_min.leave.nil?
      @l_min = @l_min.leave.strftime("%M")
    end
  end
  
  # 在社時間(退勤時間-出社時間)
  def duty_hour(d)
    if @user.attendances.find_by(day: d).arrival && @user.attendances.find_by(day: d).leave
      @duty_hour = (@user.attendances.find_by(day: d).leave - @user.attendances.find_by(day: d).arrival) / 3600
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
    @sh = Basictime.first
    if @sh.nil?
      @sh = 0.00
      @sh = sprintf("%.2f", @sh)
    else  
      @sh = Basictime.first.starting_work_at
      h = @sh.strftime("%H").to_i
      m = @sh.strftime("%M").to_f / 60
      s = h + m
      s = sprintf("%.2f", s)
    end  
  end
  
  # 指定勤務終了時間
  def finishing_hour
    @fh = Basictime.first
    if @fh.nil?
      @fh = 0.00
      @fh = sprintf("%.2f", @fh)
    else  
      @fh = Basictime.first.finishing_work_at
      h = @fh.strftime("%H").to_i
      m = @fh.strftime("%M").to_f / 60
      s = h + m
      s = sprintf("%.2f", s)
    end
  end  
  
  # 基本時間
  def basic_working_hour
    @basic_working_hours = Basictime.first
    if @basic_working_hours.nil?
      @basic_working_hours = 0.00
      @basic_working_hours = sprintf("%.2f", @basic_working_hours)
    else  
      @basic_working_hours = Basictime.first.basic_working_hours
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