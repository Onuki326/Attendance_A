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
    
  # each文で回した日付に対応する日付を返す  
  def search_date(d)
    @search_date = @user.attendances.find_by(day: d)
    @search_date = @search_date.day
  end
end