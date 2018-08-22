class UsersController < ApplicationController
  
  def edit
  end
  
  def new
    @user = User.new
  end
end
