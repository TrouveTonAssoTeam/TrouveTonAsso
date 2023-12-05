class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @donation = Donation.find(params[:donation_id])
  end

  def create
    @asso = Association.find(params[:asso_id])
    @amount = params[:amount].to_i
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          unit_amount: @amount * 100, # Stripe ne supporte que les valeurs en centimes d'où le x100
          currency: 'eur',
          product_data: {
            name: @asso.name
          }
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: payment_success_url(asso_id: @asso.id) + '&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: payment_cancel_url
    )

    redirect_to @session.url, allow_other_host: true

    # respond_to do |format|
    #   format.js # render app/views/payments/new.js.erb
    # end
  end

  def success
    # Vérifier si l'id de la session n'est pas associée à un don précédent, si oui -> redirect_back(fallback_location: root_path) avec alert
    # Rajouter dans la table donations un stripe_id
    @asso = Association.find(params[:asso_id])
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @amount = @session.amount_total / 100
    @user = current_user
  end
end