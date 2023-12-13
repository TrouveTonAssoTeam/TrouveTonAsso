class Organisation < ApplicationRecord
  has_one_attached :cover_photo
    # Devise modules
    has_many :likes
    has_many :liking_users, through: :likes, source: :user
    has_many :events, dependent: :destroy
    
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    geocoded_by :full_address
    after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

    def full_address
      [address, city, zip].compact.join(', ')
    end
    
    # Validations
    # validates :name, :description, :city, :address, :zip, presence: true
    
    has_many :donations
    has_one :cagnotte
    after_create :create_new_cagnotte
    has_many :withdrawals

    def create_new_cagnotte
      create_cagnotte
    end

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
