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
  
  
  
  # 指定勤務時間
  def specified_working_hours
    @specified_working_hours = Basictime.first
    if @specified_working_hours.nil?
      @specified_working_hours = "--:--"
    else  
      @specified_working_hours = Basictime.first.specified_working_hours
      @specified_working_hours = @specified_working_hours.strftime("%H:%M")
    end  
  end
  
  # 基本時間
  def basic_working_hours
    @basic_working_hours = Basictime.first
    if @basic_working_hours.nil?
      @basic_working_hours = "--:--"
    else  
      @basic_working_hours = Basictime.first.basic_working_hours
      @basic_working_hours = @basic_working_hours.strftime("%H:%M")
    end  
  end  
end