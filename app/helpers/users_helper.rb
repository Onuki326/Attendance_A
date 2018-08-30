module UsersHelper
  
  def this_month
    @d = DateTime.now
    @this_month = "#{@d.year}" + "年" + "#{@d.month}" + "月"
  end
  
  def first_month
    @first_month = @d.beginning_of_month
    @first_month.strftime("%m/%d")
  end
  
  def end_month
    @end_month = @d.end_of_month
    @end_month.strftime("%m/%d")
  end
end
