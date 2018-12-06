class AploysController < ApplicationController
  
  before_action :redirect_admin
  
  def create
    @user = User.new(id: params[:user_id])
    if Aploy.where(user_id: @user, day: params_aploy[:day]).blank?
      @aploy = Aploy.new(params_aploy)
      @aploy.save
    end
    redirect_to @user
  end
  
  def update
    @user = User.find(params[:user_id])
    params_aploys[:aploy].each do |aploy|
      if aploy[:state].in?(["申請中","承認","否認"]) && aploy[:change_state] == ["true"]
        @aploy = Aploy.find_by(user_id: aploy[:user_id], day: aploy[:day])
        @aploy.update(aploy)
      end
    end
    redirect_to @user
  end
  
    private
      
      def params_aploy
        params.require(:aploy).permit(:user_id, :day, :sperior_id, :state)
      end  
      
      def params_aploys
        params.permit(aploy: [:user_id, :day, :sperior_id, :state, change_state: []])
      end
end
