class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_organisation!, only: [:new, :create, :edit, :update]
  
    def index
      @events = Event.all
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

    # Action pour permettre à l'utilisateur de participer à un événement
    def attend
     current_user.events << @event unless current_user.events.include?(@event)
     redirect_to @event, notice: 'Vous participez à cet événement.'
    end

    # Action pour permettre à l'utilisateur de se désinscrire d'un événement
    def unattend
     current_user.events.delete(@event)
     redirect_to @event, notice: 'Vous ne participez plus à cet événement.'
    end

  
    private

    def set_event
        @event = Event.find(params[:id])
    end
   
    def event_params
      params.require(:event).permit(:name, :description, :start_date, :end_date, :cover_photo)
    end

  end
  