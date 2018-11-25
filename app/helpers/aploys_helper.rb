module AploysHelper
  
  def user_aploy(user)
    aploy_user = user.aploys.where(user_id: user.id)
  end
  
  def aploy_month(aploy)
      aploy.day[-2, 2]
  end
  
end