class DonationsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_correct_user?, only: [:user_donations]

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

  def create
    # @association = Association.find(params[:association_id])
    # @donation = current_user.donations.build(donation_params.merge(association: @association))

    # if @donation.save
    #   redirect_to new_payment_path
    # else
    #   render :new
    # end

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