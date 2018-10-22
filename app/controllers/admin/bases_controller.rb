class Admin::BasesController < ApplicationController
  def edit
    @base = Base.new
  end
end
