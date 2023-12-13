class Event < ApplicationRecord
  belongs_to :organisation
  has_many :attendances
  has_many :users, through: :attendances
  has_one_attached :cover_photo
  has_many :participants, through: :attendances, source: :user

  validates :name, :description, :start_date, :end_date, presence: true
end
