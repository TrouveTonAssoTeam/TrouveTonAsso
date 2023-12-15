class Tip < ApplicationRecord
    belongs_to :donation
    has_one :user, through: :donation

    validates :amount, presence: true, numericality: true, default: 0
end
