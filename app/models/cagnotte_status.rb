class CagnotteStatus < ApplicationRecord
    belongs_to :withdrawal
    validates :status, presence: true
end
