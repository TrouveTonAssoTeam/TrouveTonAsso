class Organisation < ApplicationRecord
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    # validates :name, :description, :city, :address, :zip, presence: true
    
    has_many :donations
    has_many :promoteds

    def is_promoted?
        if promoteds.where(organisation: self).where("start_date <= ? AND end_date >= ?", Date.today, Date.today).empty?
            return false
        else
            return true
        end
    end
end
