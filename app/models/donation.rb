class Donation < ApplicationRecord
    belongs_to :user
    belongs_to :organisation
    has_one :tip
    validates :amount, presence: true, numericality: { greater_than: 0 }

    def no_tip
        return self.amount - self.tip_amount
    end
end
