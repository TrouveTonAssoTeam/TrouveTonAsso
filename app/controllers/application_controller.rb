class ApplicationController < ActionController::Base
    def set_dyslexie
        cookies[:dyslexie] = params[:value]
        redirect_back fallback_location: root_path
    end

    def is_correct_user?
        if params[:profil_id] 
            @id = params[:profil_id]
        else 
            @id = params[:id]
        end
        if current_user != User.find(@id)
            redirect_back fallback_location: root_path
            flash[:alert] = "Une erreur de redirection s'est produite."
        end
    end
end
