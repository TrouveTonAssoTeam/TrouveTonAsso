class Organisation < ApplicationRecord
  has_one_attached :cover_photo
    # Devise modules
    has_many :likes
    has_many :liking_users, through: :likes, source: :user
    
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    # validates :name, :description, :city, :address, :zip, presence: true
    
    has_many :donations
    has_many :promoteds

    has_many :faqs

    def is_promoted?
        if promoteds.where(organisation: self).where("start_date <= ? AND end_date >= ?", Date.today, Date.today).empty?
            return false
        else
            return true
        end
    end
end
