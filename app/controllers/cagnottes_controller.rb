class CagnottesController < ApplicationController

    def update_cagnotte(amount, donation)
    new_cagnotte = self.cagnotte.amount + amount
    self.cagnotte.update(amount: new_cagnotte, donation: donation)
    end
    
end
