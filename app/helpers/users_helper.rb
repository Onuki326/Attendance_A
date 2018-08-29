module UsersHelper
  
  def advance_month
    @month = DateTime.now
  end
  
  def this_month
    @month = DateTime.now
    @this_month = "#{@month.year}" + "年" + "#{@month.month}" + "月"
  end
end
