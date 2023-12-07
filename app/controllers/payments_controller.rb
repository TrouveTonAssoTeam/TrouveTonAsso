class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @donation = Donation.find(params[:donation_id])
  end

  def create
    @asso = Organisation.find(params[:organisation_id])
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
      success_url: payment_success_url(organisation_id: @asso.id) + '&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: payment_cancel_url
    )

    redirect_to @session.url, allow_other_host: true

    # respond_to do |format|
    #   format.js # render app/views/payments/new.js.erb
    # end
  end

  def success
    puts "Params: #{params.inspect}" # Pour tests et vérifier les params passés dans la console
    @asso = Organisation.find(params[:organisation_id])
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @amount = @session.amount_total / 100
    @user = current_user

    # Vérifier si l'id de la session n'est pas associée à un don précédent
    existing_donation = Donation.find_by(stripe_id: params[:session_id])

    if existing_donation
      # Si oui -> redirect_back(fallback_location: root_path) avec alert
      redirect_back(fallback_location: root_path, alert: 'Une erreur est survenue.')

      else
        # Sinon sauvegarde la donation avec le stripe_id
        @donation = Donation.new
        @donation.amount = @amount
        @donation.stripe_id = params[:session_id]
        @donation.user = @user
        @donation.organisation = @asso

      if @donation.save

        # Incremente la cagnotte après chaque success donation
        @asso.update_cagnotte(@amount, @donation)

        # Si success -> page success avec une alerte de réussite
        flash.notice= "Votre don de #{@amount}€ pour #{@asso.name} a bien été effectué. Merci pour votre soutiens!"

      else
        # Sinon redirect_back(fallback_location: root_path) avec alert
        redirect_back(fallback_location: root_path, alert: 'Une erreur est survenue.')
      end
    end
  end

    def cancel
    # Si paiement annulé
    redirect_to payment_cancel_path, alert: 'Le paiement a été annulé.'
    end

end