class OrganisationsController < ApplicationController
    before_action :authenticate_organisation!
  
    def show
      @organisation = Organisation.find(params[:id])
    end
  
  end