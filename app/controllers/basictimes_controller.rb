class BasictimesController < ApplicationController
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
  end
  
   private
    def basictime_params
      params.require(:basictime).permit(:specified_working_hours, :basic_working_hours)
    end  
end