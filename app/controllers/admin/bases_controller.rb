class Admin::BasesController < ApplicationController
  
  before_action :admin_user_true?
  
  def show
    @base = Base.new
  end
end
