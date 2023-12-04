class AssociationsController < ApplicationController
    before_action :authenticate_association!
  
    def show
      @association = current_association
    end
  
    def new
      @association = Association.new
    end
  
    def create
      @association = Association.new(association_params)
  
      if @association.save
        redirect_to @association, notice: 'Association was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @association = current_association
    end
  
    def update
      @association = current_association
  
      if @association.update(association_params)
        redirect_to @association, notice: 'Association was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @association = current_association
      @association.destroy
  
      redirect_to root_path, notice: 'Association was successfully destroyed.'
    end
  
    private
  
    def association_params
      params.require(:association).permit(:name, :description, :city, :website)
    end
end