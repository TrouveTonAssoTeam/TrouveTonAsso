class Donation < ApplicationRecord
    belongs_to :user
    belongs_to :organisation
    belongs_to :cagnotte
    validates :amount, presence: true, numericality: { greater_than: 0 }
end
