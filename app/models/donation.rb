class Donation < ApplicationRecord
    belongs_to :user
    belongs_to :association
    validates :amount, presence: true, numericality: { greater_than: 0 }
end
