class Tip < ApplicationRecord
    belongs_to :donation
    has_one :user, through: :donation
end
