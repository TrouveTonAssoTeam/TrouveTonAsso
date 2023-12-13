class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_organisation!, only: [:new, :create, :edit, :update]
  
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
      @event = current_organisation.events.new(event_params)
      if @event.save
        redirect_to @event, notice: 'Événement créé avec succès.'
      else
        render :new
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
     current_user.events.delete(@event)
     redirect_to @event, notice: 'Vous ne participez plus à cet événement.'
    end

    private

    def set_event
      @organisation = Organisation.find_by(id: params[:organisation_id])
      @event = @organisation.events.find_by(id: params[:id]) if @organisation
      unless @event
        flash[:error] = "L'événement n'a pas été trouvé dans cette organisation."
        redirect_to organisation_events_path(@organisation) # Redirige vers la liste des événements de cette organisation
      end

    end
   
    def event_params
      params.require(:event).permit(:name, :description, :start_date, :end_date, :cover_photo)
    end

  end
  