class AploysController < ApplicationController
  
  before_action :redirect_admin
  
  def create
    @user = User.new(id: params[:user_id])
    if params_aploy[:sperior_id].present?
      @aploy = Aploy.new(params_aploy)
      @aploy.save
      flash[:success] = "一ヶ月分の勤怠を申請しました"
      redirect_to @user
    else
      flash[:danger] = "上長の指定がありません"
      redirect_to @user
    end
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
