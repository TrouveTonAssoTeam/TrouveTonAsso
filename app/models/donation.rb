class Donation < ApplicationRecord
    belongs_to :user
    # Utilisation de la method alias pour éviter les conflits avec Active Record et garder association dans le reste du code
    belongs_to :association_alias, class_name: 'Association', foreign_key: 'association_id'
    alias_method :association, :association_alias 
    validates :amount, presence: true, numericality: { greater_than: 0 }

end
