class DonationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @association = Association.find(params[:association_id])
    @donation = @association.donations.new
  end

  def create
    @association = Association.find(params[:association_id])
    @donation = current_user.donations.build(donation_params.merge(association: @association))

    if @donation.save
      redirect_to new_payment_path
    else
      render :new
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount)
  end
end