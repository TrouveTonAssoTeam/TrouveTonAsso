class Donation < ApplicationRecord
    belongs_to :user
    belongs_to :organisation
    validates :amount, presence: true, numericality: { greater_than: 0 }
end
