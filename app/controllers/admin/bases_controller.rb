class Admin::BasesController < ApplicationController
  
  before_action :admin_user_true?
  
  def index
    @bases = Base.all
  end
  
  def new
    @base = Base.new
  end 
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "登録できました"
      redirect_to admin_bases_url
    else
      render new
    end  
  end
  
  def edit
    @base = Base.find(params[:id])
  end  
  
  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "編集しました"
      redirect_to admin_bases_path
    else
      render edit_admin_basis(@base)
    end  
  end  
  
  def destroy
    Base.find(params[:id]).destroy
    flash[:succes] = "削除しました"
    redirect_to admin_bases_url
  end
    private
    
    def base_params
      params.require(:base).permit(:base_number, :base_name, :attendance_type)
    end  
end
