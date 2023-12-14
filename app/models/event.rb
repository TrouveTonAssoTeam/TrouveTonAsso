class Event < ApplicationRecord
  belongs_to :organisation
  has_many :attendances
  has_many :users, through: :attendances
  has_one_attached :cover_photo
  has_many :participants, through: :attendances, source: :user
  has_many :reviews

  validates :name, :description, :start_date, :end_date, presence: true


  def past?
    Time.zone.now > end_date
  end

  def status
    if end_date < Time.zone.now
      'Terminé'
    elsif start_date > Time.zone.now
      'À venir'
    else
      'En cours'
    end
  end



end
