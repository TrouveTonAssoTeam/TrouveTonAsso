class User < ApplicationRecord
  after_create :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         

    has_many :likes
    has_many :organisations, through: :likes
  has_many :donations
  has_many :attendances
  has_many :events, through: :attendances
  has_many :attended_events, through: :attendances, source: :event


  has_many :faqs
  has_one_attached :avatar

  has_many :likes
  has_many :organisations, through: :likes
  
  has_many :donations
  has_many :attendances
  has_many :events, through: :attendances
  has_many :attended_events, through: :attendances, source: :event


  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def admin?
    self.admin # Cet attribut doit être présent dans votre modèle User pour déterminer le statut d'administrateur
  end

  def name
    if self.first_name && self.last_name
      return self.first_name + " " + self.last_name.slice(0,1).upcase + "."
    elsif self.first_name
      return self.first_name
    else
      return "Anonyme"
    end
  end
end
