module UsersHelper
  
  # 月初から月末を取得
  
  def each_week
    @f = DateTime.now.beginning_of_month
    @e = DateTime.now.end_of_month
    @w = []
    (@f..@e).each do |i|
      @week.push(i.strftime("%a"))
    end
  end
end