class WithdrawalsController < ApplicationController
    before_action :authenticate_organisation!

    def index
        @organisation = current_organisation
        @withdrawals = @organisation.withdrawals.includes(:cagnotte_status).order(created_at: :desc)
    end

end
