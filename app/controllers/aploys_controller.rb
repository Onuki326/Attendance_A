class AploysController < ApplicationController
  def create
    #binding.pry
    @user = User.new(id: params[:user_id])
    if Aploy.where(user_id: @user, day: params_aploy[:day]).blank?
      @aploy = Aploy.new(params_aploy)
      @aploy.save
    end
    redirect_to @user
  end
  
    private
      
      def params_aploy
        params.require(:aploy).permit(:user_id, :day, :sperior_id, :state)
      end  
end
