class NormalsController < ApplicationController
  
  #skip_before_action :verify_authenticity_token
  
  def update
    @user = User.find(params[:user_id])
    @revises = []
    revise_params[:revise].each do |revise|
      if not revise[:change_state].blank?
        @revises.push(revise)
      end
    end
    @revises.each do |revise_data|
      @applicant = User.find_by(id: revise_data[:user_id])
      @normal_attendance = Normal.find_by(day: revise_data[:day])
      if @normal_attendance.update(revise_data)
        revise = Revise.find_by(day: revise_data[:day], user_id: revise_data[:user_id])
      #binding.pry
        revise.destroy
      end  
      if @applicant.revise_applications.blank?
        @applicant.active_relationships.find_by(requested_id: @user).destroy
      end
    end
    redirect_to @user
  end
  
    private
      def revise_params
        params.permit(revise: [:user_id, :sperior_id, :day, :arrival, :leave, :state, change_state: []])
      end  
end