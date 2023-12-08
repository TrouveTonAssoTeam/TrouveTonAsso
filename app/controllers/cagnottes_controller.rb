class CagnottesController < ApplicationController
    def show
    @organisation = Organisation.all.sample
    @cagnotte = @organisation.cagnotte
    end
end
