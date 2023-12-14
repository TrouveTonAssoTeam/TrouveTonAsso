class WithdrawalsController < ApplicationController
    before_action :authenticate_organisation!, only: [:index]
    # before_action :authenticate_admin!, only: [:admin_withdraw, :show_admin]

    def withdrawal_params
        params.require(:withdrawal).permit(:new_status)
    end

    def index
        @organisation = current_organisation
        @withdrawals = @organisation.withdrawals.includes(:cagnotte_status).order(created_at: :desc)
    end

    # Partie Admin
        def admin_withdraw
        @withdrawals = Withdrawal.includes(:organisation, :cagnotte_status).order(created_at: :desc)
        end

        def show_admin
            @withdrawal = Withdrawal.find(params[:id])
            @cagnotte_status = @withdrawal.cagnotte_status
        end
    # end
    
    def update_status
    @withdrawal = Withdrawal.find(params[:id])
    new_status = withdrawal_params[:new_status]

    if @withdrawal.cagnotte_status.present?
        if @withdrawal.cagnotte_status.update(status: new_status)
            flash.notice = 'Statut mis à jour avec succès.'
        end
        
        else
            flash.alert = 'Erreur lors de la mise à jour du statut.'
        end

        puts "Params: #{params.inspect}"

    redirect_to show_admin_withdrawal_path(@withdrawal)
    end

end
