class BasictimesController < ApplicationController
  before_action :admin_user_true?, only: [:edit, :create, :update]
  
  def edit
    if Basictime.first
      @basictime = Basictime.first
    else
      @basictime = Basictime.new
    end
  end

  def create
    @user = current_user
    @basictime = Basictime.new(basictime_params)
    @basictime.save
    redirect_to @user
  end

  def update
    @user = current_user
    @basictime = Basictime.find(params[:id])
    @basictime.update_attributes(basictime_params)
    redirect_to @user
  end
  
   private
    def basictime_params
      params.require(:basictime).permit(:specified_working_hours, :basic_working_hours)
    end
    
end