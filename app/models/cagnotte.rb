class Cagnotte < ApplicationRecord
    belongs_to :organisation
    belongs_to :donation
    validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
