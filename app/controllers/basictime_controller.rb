class BasictimeController < ApplicationController
  def edit
    if Basictime.first
      @basic_time = Basictime.first
    else
      @basic_time = Basictime.new
    end
  end

  def create
  end

  def update
  end
end
