class Cagnotte < ApplicationRecord
    belongs_to :organisation
    attribute :amount, :integer, default: 0
    attr_accessor :withdrawal_amount
end
