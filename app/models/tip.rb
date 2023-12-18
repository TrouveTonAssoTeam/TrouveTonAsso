class Tip < ApplicationRecord
    belongs_to :donation
    has_one :user, through: :donation

    attribute :amount, default: 0
    validates :amount, presence: true, numericality: true
end
