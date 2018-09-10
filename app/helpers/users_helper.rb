module UsersHelper
  
  # 出社時間
  def arrival_hour(d)
    @hour = @user.attendances.find_by(day: d)
    @hour = @hour.arrival.strftime("%H")
  end
  
  # 出社時間(分)
  def arrival_min(d)
    @min = @user.attendances.find_by(day: d)
    @min = @min.arrival.strftime("%M")
  end
    
  # 今日の日付と出勤、退勤の日付をあっているか調べる  
  
end