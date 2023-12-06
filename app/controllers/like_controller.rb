class LikeController < ApplicationController
    before_action :authenticate_user!
     
    def index 

    end

    est_like = false
    def gerer_like(est_like)
        if !est_like
            puts "Vous avez bien liker cette page"
            est_like = true
        else
            puts "Pourquoi ce dislike enculé ?"
            esr_like = false
    end

    return est_like
end
est_like = gerer_like(est_like)
    def like
        puts "Vous avez bien liker cette page"
    end

    def unlike
        puts "Pourquoi ce dislike enculé ?"
    end

    def like_asso
        # Générer l'URL pour le like en utilisant l'ID
        like_path(id) 
       
    end
    
    def unlike_asso
        # Générer l'URL pour le unlike en utilisant l'ID
        unlike_path(id)
        
    end
end

