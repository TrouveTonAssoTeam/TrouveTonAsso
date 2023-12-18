class Faq < ApplicationRecord
    belongs_to :organisation
    belongs_to :user

    validates :question, presence: true
end
