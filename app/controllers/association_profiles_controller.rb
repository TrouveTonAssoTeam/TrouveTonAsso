class AssociationProfilesController < ApplicationController
  before_action :authenticate_association!, only: [:new, :create, :edit, :update]
  before_action :set_association_profile, only: [:edit, :update]

  # Afficher le profil de l'association
  def show
    if current_association.present?
      @association_profile = AssociationProfile.find_by(association_id: current_association.id)
      if @association_profile
        # Afficher les détails du profil de l'association
      else
        flash[:error] = "Le profil de l'association n'a pas été trouvé."
        redirect_to root_path # Redirection en cas de profil d'association non trouvé
      end
    else
      flash[:error] = "Aucune association n'est actuellement définie."
      redirect_to root_path # Redirection en cas d'association actuelle non définie
    end
  end

  # Créer un nouveau profil de l'association
  def create
    @association_profile = AssociationProfile.new(association_profile_params)

    if @association_profile.save
      redirect_to @association_profile, notice: 'Profil créé avec succès'
    else
      render :new # Affichage du formulaire en cas d'échec de sauvegarde
    end
  end

  # Afficher le formulaire pour éditer le profil de l'association
  def edit
    # La logique pour l'édition est déjà gérée par le before_action :set_association_profile
  end

  # Mettre à jour le profil de l'association
  def update
    if @association_profile.update(association_profile_params)
      redirect_to @association_profile, notice: 'Profil mis à jour avec succès'
    else
      render :edit # Affichage du formulaire d'édition en cas d'échec de mise à jour
    end
  end

  private

  # Définir le profil de l'association basé sur l'ID
  def set_association_profile
    @association_profile = AssociationProfile.find(params[:id])
    redirect_to root_path, notice: "Vous n'êtes pas autorisé à modifier ce profil" unless current_association == @association_profile.association
  end

  # Méthode pour filtrer les paramètres acceptés pour la création/mise à jour du profil
  def association_profile_params
    params.require(:association_profile).permit(:description, :other_attributes)
  end
end
