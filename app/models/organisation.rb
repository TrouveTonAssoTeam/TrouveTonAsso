class Organisation < ApplicationRecord
  has_one_attached :cover_photo
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :confirmable
  
    # Validations
    # validates :name, :description, :city, :address, :zip, presence: true
    
    has_many :donations
end
