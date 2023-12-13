class Withdrawal < ApplicationRecord
    belongs_to :organisation
    validates :amount, presence: true, numericality: { greater_than: 0 }
    has_one :cagnotte_status

end
