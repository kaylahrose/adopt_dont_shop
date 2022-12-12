class PetApplicationsController < ApplicationController
  def create
    PetApplication.create(pet_app_params)
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    pet_application = PetApplication.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
    pet_application.update(pet_app_params)
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

private 
  def pet_app_params
    params.permit(:application_id, :pet_id, :approved)
  end
end