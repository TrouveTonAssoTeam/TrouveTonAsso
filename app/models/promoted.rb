class Promoted < ApplicationRecord
    belongs_to :organisation

    def duration
        (self.end_date - self.start_date).to_i
    end

    def state
        if self.start_date > Date.today
            "À venir"
        elsif self.end_date >= Date.today
            "En cours"
        else
            "Terminé"
        end
    end
end
