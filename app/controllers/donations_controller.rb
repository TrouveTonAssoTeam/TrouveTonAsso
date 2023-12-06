class DonationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @association = Association.all.sample
      # Si pas d'asso renvoie à l'index
      if @association.nil?
      flash[:alert] = "Nous n'avons pas pu trouvé l'association choisie."
      redirect_to root_path
      end
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