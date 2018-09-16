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
  
  def total_hour
    
    if @user.attendances.find_by(day: Date.today)
      @hours = []
      @d.each do |d|
        if @user.attendances.find_by(day: d).arrival && @user.attendances.find_by(day: d).leave
          #@hours.push((@user.attendances.find_by(day: d).leave - @user.attendances.find_by(day: d).arrival))
          a = (@user.attendances.find_by(day: d).leave - @user.attendances.find_by(day: d).arrival) / 3600
          a = sprintf("%.2f", a).to_f
          @hours.push(a)
        end
      end
      @hours.sum
    end  
  end  
end