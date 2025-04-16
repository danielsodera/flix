class Genre < ApplicationRecord
  
  before_save :lowercase_genre

  has_many :characterizations, dependent: :destroy 
  has_many :movies, through: :characterizations

  validates :name, presence: true, uniqueness: true 

end
