class PromotedController < ApplicationController
    before_action :authenticate_organisation!, only: [:index]
    def index

    end

    def new

    end

    def go_to_paiement

    end

    def paiement_success

    end
end
