class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @donation = Donation.find(params[:donation_id])
    @asso = @donation.organisation
  end

  def create
    @asso = Organisation.find(params[:organisation_id])
    @amount = (params[:amount].to_f * 100).to_i # Stripe ne supporte que les valeurs en centimes d'où le x100

    # Gestion du tip au payment : tip_amount est soit 100 soit 0 si checkbox uncheked et no_tip = montant du dons - montant du tip
    @tip_amount = params[:tip].to_i == 1 ? 100 : 0 # 100 cents = 1 euro
    @no_tip = @amount - @tip_amount

    
    @session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            unit_amount: @amount,
            currency: 'eur',
            product_data: {
              name: @asso.name
            }
          },
          quantity: 1
        },
        {
          price_data: {
            unit_amount: @tip_amount,
            currency: 'eur',
            product_data: {
              name: 'Participation'
            }
          },
          quantity: 1
        }
      ],
      mode: 'payment',
      success_url: payment_success_url(organisation_id: @asso.id, tip: params[:tip]) + '&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: payment_cancel_url
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @asso = Organisation.find(params[:organisation_id])
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @amount = @session.amount_total / 100.0
    @user = current_user
    @tip_amount = params[:tip].to_i == 1 ? 100 / 100.0 : 0 # Ici on divise 100 par 100 pour obtenir 1 et pouvoir soustraire avec le tip
    @no_tip = @amount - @tip_amount

    # Vérifier si l'id de la session n'est pas associée à un don précédent
    existing_donation = Donation.find_by(stripe_id: params[:session_id])

    if existing_donation
      # Si oui -> redirect_back(fallback_location: root_path) avec alert
      redirect_back(fallback_location: root_path, alert: "Il semble qu'il y ai déjà un don avec cet id.")

      else
        # Sinon sauvegarde la donation avec le stripe_id
        @donation = Donation.new(
          amount: @amount,
          stripe_id: params[:session_id],
          user: @user,
          organisation: @asso,
          tip_amount: @tip_amount,
          no_tip: @no_tip
        )

        # Incremente la cagnotte après chaque success donation
        @asso.cagnotte.increment!(:amount, @donation.no_tip)
        
      if @donation.save
      
        # Si success -> page success avec une alerte de réussite
        flash.notice= "Votre don de #{@no_tip}€ pour #{@asso.name} a bien été effectué. Merci pour votre soutiens!"
      else
        # Sinon redirect_back(fallback_location: root_path) avec alert
        redirect_back(fallback_location: root_path, alert: "Une erreur est survenue. Votre don n'a pas été sauvegardé.")
      end
    end
  end

    def cancel
    # Si paiement annulé
    redirect_to payment_cancel_path, alert: 'Le paiement a été annulé.'
    end

end