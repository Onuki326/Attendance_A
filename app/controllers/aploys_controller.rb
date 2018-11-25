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
  
  def update
    params_aploys[:aploy].each do |aploy|
      if aploy[:state].in?(["申請中","承認","否認"]) && aploy[:change_state] == true
        @aploy = Aploy.where(user_id: aploy[:user_id], day: aploy[:day])
        #binding.pry
        @aploy.update(aploy)
      end
    end
  end
  
    private
      
      def params_aploy
        params.require(:aploy).permit(:user_id, :day, :sperior_id, :state)
      end  
      
      def params_aploys
        params.permit(aploy: [:user_id, :day, :sperior_id, :state, change_state: []])
      end
end
