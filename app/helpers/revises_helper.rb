module RevisesHelper
  
  # reviseの日付
  def revise_day(revise)
    revise.day.strftime("%m/%d")
  end
  # reviseの曜日
  def revise_week(revise, weeks)
    week = revise.day.wday
    weeks[week]
  end
  
  # reviseの出社時間(時)
  def revise_arrival_hour(revise)
    revise.arrival.strftime("%H")
  end
  
  # reviseの出社時間(分)
  def revise_arrival_min(revise)
      revise.arrival.strftime("%M")
  end
  
  # reviseの退社時間(時)
  def revise_leave_hour(revise)
    revise.leave.strftime("%H")
  end
  
  # reviseの退社時間(分)
  def revise_leave_min(revise)
    revise.leave.strftime("%M")
  end
  
  # normmalの出社時間(時)
  def normal_arrival_hour(user, revise)
    normal = user.normal_applications.find_by(day: revise.day)
    normal.arrival.strftime("%H")
  end
  
  # normalの出社時間(分)
  def normal_arrival_min(user, revise)
    normal = user.normal_applications.find_by(day: revise.day)
    normal.arrival.strftime("%M")
  end
  
  # normalの退社時間(時)
  def normal_leave_hour(user, revise)
    normal = user.normal_applications.find_by(day: revise.day)
    normal.leave.strftime("%H")
  end
  
  # normalの退社時間(分)
  def normal_leave_min(user, revise)
    normal = user.normal_applications.find_by(day: revise.day)
    normal.leave.strftime("%M")
  end
  
  # select-box用 第二引数に入れる
  def sperior_users(speriors)
    speriors.map {|u| [u.name, u.id]}
  end
  
  # ユーザーの申請情報
  def user_apploy_to_srerior(user)
    user.revise_applications.where(sperior_id: @user)
  end
end
