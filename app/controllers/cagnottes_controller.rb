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
            @withdrawal = @organisation.withdrawals.new(amount: withdrawal_amount)

            # Save la demande
            if @withdrawal.save
            # Création du status en cours de traitement quand une nouvelle demande est lancée
            @withdrawal.create_cagnotte_status(status: 'En cours de traitement')

            flash.notice = "Votre demande de retrait de #{withdrawal_amount}€ a été effectuée avec succès."
            else
            flash.alert = "Erreur lors de la création de la demande de retrait."
            end

        else
            flash.alert = "Montant de retrait invalide."
        end
    redirect_to cagnotte_path(@organisation)
    end

    private

    def set_cagnotte
        @cagnotte = current_organisation.cagnotte
    end

    def create_cagnotte_status(withdrawal:, status:)
    cagnotte_status = CagnotteStatus.create(
        withdrawal: withdrawal,
        status: status
    )
    end
end
