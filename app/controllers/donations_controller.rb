class DonationsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:user_donations]

  def new
    @organisation = Organisation.find(params[:organisation_id])
  end

  def user_donations
    @user_donations = current_user.donations
  end

  def organisation_donations
    @organisation_donations = current_organisation.donations
  end

  def create
    puts "$" * 20
    puts params
    puts "$" * 20
  end
  
  private

  def donation_params
    # Ajout du stripe_id 
    params.require(:donation).permit(:amount, :stripe_id)
  end
end