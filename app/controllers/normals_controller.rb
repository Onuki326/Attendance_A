class NormalsController < ApplicationController
  
  #skip_before_action :verify_authenticity_token
  
  def update
    @user = User.find(params[:user_id])
    @revises = []
    revise_params[:revise].each do |revise|
      @revises.push(revise)
    end
    @revises.each do |revise_data|
    #binding.pry
      revise_attendance = Normal.find_by(day: revise_data[:day])
      revise_attendance.update(revise_data)
    end
    redirect_to @user
  end
  
    private
      def revise_params
        params.permit(revise: [:user_id, :sperior_id, :day, :arrival, :leave, :state])
      end  
end
