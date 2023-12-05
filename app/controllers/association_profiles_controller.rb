class AssociationProfilesController < ApplicationController
    before_action :authenticate_association!, only: [:new, :create, :edit, :update]
    before_action :set_association_profile, only: [:edit, :update]

  
    def show
      @association_profile = AssociationProfile.find_by(association: current_association)
      if @association_profile
        # La logique pour afficher les détails du profil de l'association
      else
        redirect_to root_path, notice: "Aucun profil trouvé"
      end
    end
  
    def new
      @association_profile = AssociationProfile.new
    end
  
    def create
      @association_profile = AssociationProfile.new(association_profile_params)
      @association_profile.association = current_association # Assurez-vous que l'association est correctement associée
      
      if @association_profile.save
        redirect_to @association_profile, notice: 'Profil créé avec succès'
      else
        render :new
      end
    end
  
    def edit
      # La logique pour l'édition est déjà gérée par le before_action :set_association_profile
    end
  
    def update
      if @association_profile.update(association_profile_params)
        redirect_to @association_profile, notice: 'Profil mis à jour avec succès'
      else
        render :edit
      end
    end
  
    private
  
    def set_association_profile
      @association_profile = AssociationProfile.find(params[:id])
      redirect_to root_path, notice: "Vous n'êtes pas autorisé à modifier ce profil" unless current_association == @association_profile.association
    end
  
    def association_profile_params
      params.require(:association_profile).permit(:description, :other_attributes)
    end
  end
  