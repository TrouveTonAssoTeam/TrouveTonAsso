class PromotedController < ApplicationController
    before_action :authenticate_organisation!, only: [:index]
    def index
        @organisation = current_organisation
        
        @all_promoted = Promoted.where(organisation: current_organisation).order(created_at: :desc)
        @total_duration = 0
        @all_promoted.each do |promoted|
            @total_duration += promoted.duration
        end

        @total_price = 0
        @all_promoted.each do |promoted|
            @total_price += promoted.price
        end

        @current_promoted = Promoted.where(organisation: current_organisation).where("end_date >= ?", Date.today).order(end_date: :desc)
        @is_promoted = @current_promoted.empty? ? false : true
        
        if @is_promoted
            @remaining_days = (@current_promoted[0].end_date - Date.today + 1).to_i
        end
    end

    def new
        @organisation = current_organisation
        
        @current_promoted = Promoted.where(organisation: current_organisation).where("end_date >= ?", Date.today).order(end_date: :desc)
        @is_promoted = @current_promoted.empty? ? false : true
        
        @today = Date.today

        if @is_promoted
            @remaining_days = (@current_promoted[0].end_date - Date.today + 1).to_i
            @today = @current_promoted[0].end_date
        end
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
            customer_email: @organisation.email,
            metadata: {
                weeks: @weeks
            },
            mode: 'payment',
            success_url: success_organisation_promoted_index_url + '?session_id={CHECKOUT_SESSION_ID}',
            cancel_url: cancel_organisation_promoted_index_url
        )

        redirect_to @session.url, allow_other_host: true
    end

    def success
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])

        if Promoted.where(stripe_id: @session.id).empty?
            @weeks = @session.metadata.weeks.to_i
            @total = @session.amount_total / 100

            @promoted = Promoted.new
            @promoted.organisation = current_organisation

            if current_organisation.promoteds.where("end_date > ?", Date.today).empty?
                @start_date = Date.today
            else 
                @start_date = current_organisation.promoteds.where("end_date > ?", Date.today).order(end_date: :desc)[0].end_date + 1
            end
            @promoted.start_date = @start_date
            @promoted.end_date = @start_date + @weeks * 7
            @promoted.price = @total
            @promoted.stripe_id = @session.id

            if @promoted.save
                redirect_to organisation_promoted_index_path, notice: "Merci pour votre paiement de #{@total} €. Votre association sera mise en avant pour #{@weeks * 7} jours de plus."
            else
                redirect_to organisation_promoted_index_path, alert: "Une erreur est survenue. Merci de contacter le support pour plus d'informations."
            end
        else
            redirect_back(fallback_location: organisation_promoted_index_path, alert: "Une erreur est survenue.")
        end
    end

    def cancel
        redirect_to organisation_promoted_index_path, alert: "Le paiement a été annulé."
    end
end
