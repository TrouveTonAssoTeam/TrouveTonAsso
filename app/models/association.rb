class Association < ApplicationRecord
    # Devise modules
    has_many :likes
    has_many :liking_users, through: :likes, source: :user
    
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    validates :name, :description, :city, :website, presence: true
  
end
