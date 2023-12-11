class Organisation < ApplicationRecord
  has_one_attached :cover_photo
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    # validates :name, :description, :city, :address, :zip, presence: true
    
    has_many :donations
    has_one :cagnotte
    after_create :create_new_cagnotte
    has_many :withdrawals

    def create_new_cagnotte
      create_cagnotte(amount: 0)
    end

end
