class BasictimesController < ApplicationController
  def edit
    if Basictime.first
      @basictime = Basictime.first
    else
      @basictime = Basictime.new
    end
  end

  def create
    
  end

  def update
  end
  
   private
    def basictime_params
      params.require(:basetime).permit(:specified_working_hours, :basic_working_hours)
    end  
end