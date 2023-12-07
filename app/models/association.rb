class Association < ApplicationRecord
    has_one_attached :cover_photo
    after_create :create_association_profile

    private

    def create_association_profile
      AssociationProfile.create(association: self)
    end


    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    # Validations
    validates :name, :description, :city, :website, presence: true
  
end
