class AssociationsController < ApplicationController
    before_action :authenticate_association!
  
    def show
      @association = Association.find(params[:id])
    end
  
  end