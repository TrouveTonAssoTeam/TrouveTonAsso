class Association < ApplicationRecord
    has_one :association_profile, foreign_key: 'association_reference'
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    validates :name, :description, :city, :website, presence: true
  
    after_create :create_association_profile
  
    private
  
    def create_association_profile
      AssociationProfile.create(association_reference: self)
    end
  end
  