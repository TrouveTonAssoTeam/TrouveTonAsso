class PromotedController < ApplicationController
    before_action :authenticate_organisation!, only: [:index]
    def index
        @organisation = current_organisation
        
        @past_promoted = Promoted.where(organisation: current_organisation).where("start_date <= ?", Date.today).order(created_at: :desc)
        @current_promoted = Promoted.where(organisation: current_organisation).where("start_date <= ? AND end_date >= ?", Date.today, Date.today).order(end_date: :desc)
        @is_promoted = @current_promoted.empty? ? false : true
        
        if @is_promoted
            @remaining_days = (@current_promoted[0].end_date - Date.today).to_i
        end
    end

    def new
        @organisation = current_organisation
        
        @current_promoted = Promoted.where(organisation: current_organisation).where("start_date <= ? AND end_date >= ?", Date.today, Date.today).order(end_date: :desc)
        @is_promoted = @current_promoted.empty? ? false : true

        if @is_promoted
            @remaining_days = @current_promoted[0].end_date - Date.today
        end

        @today = Date.today
    end

    def go_to_paiement
        @weeks = params[:weeks].to_i
        @organisation = current_organisation

        case @weeks
        when 1
            @amount = 500
        when 2
            @amount = 950
        when 3
            @amount = 1350
        when 4
            @amount = 1700
        end

        @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
            line_items: [{
                price_data: {
                unit_amount: @amount,
                currency: 'eur',
                product_data: {
                    name: "#{@weeks} semaine#{(@weeks == 1) ? "" : "s"} de mise avant de votre association #{@organisation.name} sur TrouveTonAsso"
                }
                },
                quantity: 1
            }],
            metadata: {
                weeks: @weeks
            },
            mode: 'payment',
            success_url: promoted_success_url + '?session_id={CHECKOUT_SESSION_ID}',
            cancel_url: promoted_cancel_url
        )

        redirect_to @session.url, allow_other_host: true
    end

    def paiement_success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @weeks = @session.metadata.weeks.to_i
        @total = @session.amount_total / 100

        @promoted = Promoted.new
        @promoted.organisation = current_organisation
        @promoted.start_date = Date.today
        @promoted.end_date = Date.today + @weeks * 7
        @promoted.price = @total
        @promoted.stripe_id = @session.id

        if @promoted.save
            redirect_to promoted_index_path, notice: "Merci pour votre paiement de #{@total} €. Votre association sera mise en avant pour #{@weeks * 7} jours de plus."
        else
            redirect_to promoted_index_path, alert: "Une erreur est survenue. Merci de contacter le support pour plus d'informations."
        end
    end
end
