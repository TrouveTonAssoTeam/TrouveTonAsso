class CagnottesController < ApplicationController
    before_action :authenticate_organisation!

    def show
    @organisation = current_organisation
    @cagnotte = @organisation.cagnotte
    end

    private

    def set_cagnotte
        @cagnotte = current_organisation.cagnotte
    end
end
