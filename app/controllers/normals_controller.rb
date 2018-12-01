class NormalsController < ApplicationController
  
  
  def update
    @user = User.find(params[:user_id])
    @revises = []
    revise_params[:revise].each do |revise|
      if not revise[:change_state].blank?
        @revises.push(revise)
      end
    end
    @revises.each do |revise_data|
      @appliant = User.find_by(id: revise_data[:user_id])
      @normal_attendance = Normal.find_by(user_id: @appliant.id, day: revise_data[:day])
      if revise_data[:state] == "承認"
        @normal_attendance.update(revise_data)
        revise = Revise.find_by(day: revise_data[:day], user_id: revise_data[:user_id])
        revise.destroy
      elsif revise_data[:state] == "否認"
        @normal_attendance.update(state: revise_data[:state])
        revise = Revise.find_by(day: revise_data[:day], user_id: revise_data[:user_id])
        revise.destroy
      end
      #if @appliant.revise_applications.where(state: "申請中").blank? && @appliant.overtime_applications.where(state: "申請中").blank?
      #  @appliant.active_relationships.find_by(requested_id: @user).destroy
      #end
    end
    redirect_to @user
  end
  
    private
      def revise_params
        params.permit(revise: [:user_id, :sperior_id, :day, :arrival, :leave, :state, change_state: []])
      end  
end
