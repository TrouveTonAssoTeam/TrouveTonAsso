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
end
