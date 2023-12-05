class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @donation = Donation.find(params[:donation_id])
  end

  def create
    @donation = Donation.find(params[:donation_id])
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: "Don à #{Association.find(@donation.association_id).name}",
        amount: @donation.amount * 100, # Stripe ne supporte que les valeurs en centimes d'où le x100
        currency: 'eur',
        quantity: 1
      }],
      success_url: root_path,
      cancel_url: root_path
    )

    respond_to do |format|
      format.js # render app/views/payments/new.js.erb
    end
  end
end