class Cagnotte < ApplicationRecord
    belongs_to :organisation
    attribute :amount, default: 0
    attr_accessor :withdrawal_amount
end
