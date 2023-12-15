class Promoted < ApplicationRecord
    belongs_to :organisation

    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :price, presence: true

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
