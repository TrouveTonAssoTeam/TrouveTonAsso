class AssociationsController < ApplicationController
    before_action :authenticate_association!
    
    validates :name, :description, :city, :website, presence: true
  
    def show
      
    end
  
    def new
      
    end
  
    def create
     
    end
  
    def edit
 
    end
  
    def update
  
    end
  
    def destroy
      
    end
  
    private
  
    def association_params
      params.require(:association).permit(:name, :description, :city, :website)
    end
end