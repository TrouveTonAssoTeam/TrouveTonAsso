class AssociationsController < ApplicationController
    before_action :authenticate_association!
  
    def show
      @association = Association.find(params[:id])
    end
  
    def index 
      @liked_associations = current_user.associations
    end
    
  end