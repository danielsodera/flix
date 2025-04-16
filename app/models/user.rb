class User < ApplicationRecord

  before_save :lowercase_username
  before_save :lowercase_email

  has_many :reviews, dependent: :destroy 
  has_many :favourites, dependent: :destroy
  has_many :favourite_movies, through: :favourites, source: :movie 

  has_secure_password

  validates :name, presence: true 

  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 10, allow_blank: true }

  validates :username, format: { with: /\A[A-Z0-9]+\z/i }, uniqueness: {case_sensitive: false}


  scope :by_name, -> { order(:name) }
  scope :non_admins, -> { by_name.where(admin: false)}

  def lowercase_username
    self.username = username.downcase
  end

  def lowercase_email
    self.email = email.downcase
  end

  def to_param 
    username
  end

end
