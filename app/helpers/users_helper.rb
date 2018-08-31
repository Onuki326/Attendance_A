module UsersHelper
  
  # 今月を取得
  def now_month
    @now_month = "#{@d.year}" + "年" + "#{@d.month}" + "月"
  end
  
  # 月初を取得
  def beginning_month
    @begininng_month = @d.beginning_of_month
    @begininng_month.strftime("%m/%d")
  end
  
  # 締め日を取得
  def end_month
    @end_month = @d.end_of_month
    @end_month.strftime("%m/%d")
  end
  
  # 月初から月末を取得
  def this_month
    @this_month = []
    (@first_month..@end_month).each do |i|
      @thismonth.push(i.strftime("%m/%d","%a"))
    end
  end
  
  def each_week(date)
    @f = date.beginning_of_month
    @e = date.end_of_month
    @w = []
    (@first_month..@end_month).each do |i|
      @week.push(i.strftime("%a"))
    end
  end
end