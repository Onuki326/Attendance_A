module OvertimesHelper
  # overtimeの日付
  def overtime_day(overtime)
    overtime.day.strftime("%m/%d")
  end
  # overtimeの曜日
  def overtime_week(overtime, weeks)
    week = overtime.day.wday
    weeks[week]
  end
  
  # overtimeの終了予定時間(時)
  def overtime_finish_hour(overtime)
    overtime.finish_at.strftime("%H")
  end
  
  # overtimeの終了予定時間(分)
  def overtime_finish_min(overtime)
      overtime.finish_at.strftime("%M")
  end
  
  # 指定勤務終了時間
  def overtime_finishing_hour(requester_user)
    finish_hour = requester_user.finishing_work_at
    if finish_hour.nil?
      finish_hour = 0.00
      finish_hour = sprintf("%.2f", finish_hour)
    else
      h = finish_hour.strftime("%H").to_i
      m = finish_hour.strftime("%M").to_f / 60
      s = h + m
      s = sprintf("%.2f", s)
    end
  end
  
  # overtimeの終了予定時間
  def overtime_finish_at(requester_user, overtime)
    finish_hour = requester_user.overtime_applications.find_by(day: overtime.day)&.finish_at
    if finish_hour.nil?
      finish_hour = 0.00
      finish_hour = sprintf("%.2f", finish_hour)
    else
      h = finish_hour.strftime("%H").to_i
      m = finish_hour.strftime("%M").to_f / 60
      s = h + m
      s = sprintf("%.2f", s)
    end
  end
    
  # 時間外時間
  def overtime_work(requester_user, overtime)
    finishing_hour = requester_user.overtime_applications.find_by(day: overtime.day).finish_at
    finish_hour = requester_user.finishing_work_at
    finish_hour = finish_hour.change(day: overtime.day.day) if finish_hour != nil
    overtime_hour = (finishing_hour - finish_hour) / 3600
    overtime_hour = sprintf("%.2f", overtime_hour)
  end
    
  # ユーザーの申請情報
  def user_overtime_apploy_to_srerior(user)
    user.overtime_applications.where(sperior_id: @user)
  end
  
  
  
  
  
  
  
  
  # reviseの退社時間(時)
  def overtime_leave_hour(overtime)
    overtime.leave.strftime("%H")
  end
  
  # reviseの退社時間(分)
  def overtime_leave_min(overtime)
    overtime.leave.strftime("%M")
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
