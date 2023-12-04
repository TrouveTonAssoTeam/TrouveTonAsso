class Association < ApplicationRecord
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    validates :name, :description, :city, :website, presence: true
  
end
