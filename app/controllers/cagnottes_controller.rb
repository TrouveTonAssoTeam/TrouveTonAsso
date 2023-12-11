class CagnottesController < ApplicationController
    before_action :authenticate_organisation!

    def show
        @organisation = current_organisation
        @cagnotte = @organisation.cagnotte
    end

    def withdrawal
        @withdrawal = Withdrawal.new
    end

    def process_withdrawal
        @organisation = current_organisation
        @cagnotte = @organisation.cagnotte

    withdrawal_amount = params[:withdrawal][:amount].to_f
        if @cagnotte.amount >= withdrawal_amount && withdrawal_amount > 0
            # Decrement la cagnotte et update la cagnotte
            @cagnotte.decrement!(:amount, withdrawal_amount)
             # Nouvelle demande de retrait 
            @withdrawal = @organisation.withdrawals.create(amount: withdrawal_amount)
            # Creation du status en cours de traitement quand une nouvelle demande est lancée
            @withdrawal.create_cagnotte_status(
            amount: withdrawal_amount,
            status: 'En cours de traitement',
            organisation: @organisation
            )

            flash.notice = "Votre demande de retrait de #{withdrawal_amount}€ a été effectuée avec succès."
        else
            flash.alert = "Montant de retrait invalide."
        end
    redirect_to cagnotte_path(current_organisation)
    end

    private

    def set_cagnotte
        @cagnotte = current_organisation.cagnotte
    end

    def create_cagnotte_status(withdrawal_amount:, organisation:)
    cagnotte_status = CagnotteStatus.new(
        amount: withdrawal_amount,
        status: 'En cours de traitement',
        organisation: organisation
        )
    end
end
