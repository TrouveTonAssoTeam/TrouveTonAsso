class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_organisation!, only: [:new, :create, :edit, :update], unless: -> { current_user&.admin? }

  
    def index
      @organisation = Organisation.find_by(id: params[:organisation_id])
      if @organisation.present?
        @events = @organisation.events # Assurez-vous que cette ligne récupère les événements liés à l'organisation
      else
        flash[:error] = "Organisation introuvable"
        redirect_to events_path # Redirige vers une page appropriée en cas d'organisation non trouvée
      end
    end
  
    def show
    end

    def new
      @event = Event.new
    end
  
    def create 
      if params[:organisation_id]
        current_organisation = Organisation.find(params[:organisation_id])
        @event = current_organisation.events.new(name:params[:titre], description:params[:description], organisation_id:params[:organisation_id], start_date:params[:start_date], end_date:params[:end_date])
        if @event.save
        redirect_to @event, notice: 'Événement créé avec succès.'
      else
        render :new
      end

      else
      @event = current_organisation.events.new(event_params)
      if @event.save
        redirect_to @event, notice: 'Événement créé avec succès.'
      else
        render :new
      end
    end
    end
  
  
    def edit
      # Afficher le formulaire pour modifier un événement existant
    end
  
    def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Événement mis à jour avec succès.'
      else
        render :edit
      end
    end
  
    def destroy
      @event.destroy
      redirect_to events_url, notice: 'Événement supprimé avec succès.'
    end

    def attend
      @event = Event.find(params[:id]) # Récupérer l'événement en fonction de son ID
      if @event && !current_user.events.include?(@event)
        current_user.events << @event
        redirect_to @event, notice: 'Vous participez à cet événement.'
      else
        redirect_to root_path, alert: 'L\'événement est introuvable ou vous y participez déjà.'
      end
    end

    # Action pour permettre à l'utilisateur de se désinscrire d'un événement
    def unattend
     @event = Event.find(params[:id])
     current_user.events.delete(@event)
     redirect_to @event, notice: 'Vous ne participez plus à cet événement.'
    end

    def past?
      Time.zone.now > end_date
    end

    def status
      if end_date < Time.zone.now
        update(status: 'Terminé')
      elsif start_date > Time.zone.now
        update(status: 'À venir')
      else
        update(status: 'En cours')
      end
    end

    def create_review
      @event = Event.find(params[:id])
      @review = @event.reviews.build(review_params)
      @review.user = current_user
  
      if @review.save
        flash[:success] = "Votre avis a été ajouté avec succès !"
        redirect_to @event
      else
        flash[:error] = "Erreur lors de l'ajout de l'avis"
        render 'show'
      end
    end

    private

    def review_params
      params.require(:review).permit(:rating, :body)
    end

    def set_event
      @organisation = Organisation.find_by(id: params[:organisation_id])
      @event = Event.find_by(id: params[:id])
      unless @event
        flash[:error] = "L'événement n'a pas été trouvé dans cette organisation."
        redirect_back(fallback_location: organisations_path)# Redirige vers la liste des événements de cette organisation
      end

    end
   
    def event_params
      params.require(:event).permit(:name, :description, :start_date, :end_date, :cover_photo)
    end

  end
  