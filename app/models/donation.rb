class Donation < ApplicationRecord
    belongs_to :user
    belongs_to :organisation
    has_one :tip
    validates :amount, presence: true, numericality: { greater_than: 0 }
end
