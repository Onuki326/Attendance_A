class NormalsController < ApplicationController
  
  #skip_before_action :verify_authenticity_token
  
  def update
    @user = User.find(params[:user_id])
    @revises = []
      binding.pry
    revise_params[:revise].each do |revise|
      if not revise[:sperior_id].nil?
        @revises.push(revise)
      end
    end
    @revises.each do |revise_data|
      if revise_data[:change_state] == "true"
        @applicant = User.find_by(id: revise_data[:user_id])
        @revise_attendance = Normal.find_by(day: revise_data[:day])
        @revise_attendance.update(revise_data)
        if @applicant.revise_applications.blank?
          @applicant.active_relationships.find_by(requested_id: @user.id).destroy
          #relation.destroy
        end
      end
    end
    redirect_to @user
  end
  
    private
      def revise_params
        params.permit(revise: [:user_id, :sperior_id, :day, :arrival, :leave, :state, :change_state])
      end  
end
