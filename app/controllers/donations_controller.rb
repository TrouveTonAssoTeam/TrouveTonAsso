class DonationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @organisation = Organisation.all.sample
      # Si pas d'asso renvoie à l'index
      if @organisation.nil?
      flash[:alert] = "Nous n'avons pas pu trouvé l'association choisie."
      redirect_to root_path
      end
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