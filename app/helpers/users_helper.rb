module UsersHelper
  
  # eachで回した日付のAttendance
  def attendance_today(d)
    @attendance_today = @user.attendances.find_by(day: d)
  end  
  
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
  
  # each文で回した日付に対応する日付を返す  
  def search_date(d)
    @search_date = @user.attendances.find_by(day: d)
    @search_date = @search_date.day
  end
end