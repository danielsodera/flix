class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  STARS = [1, 2, 3, 4, 5] 
  validates :stars, inclusion: { in: STARS, message: "Must be between 1 and 5"}


  def stars_as_percent
    (stars / 5.0) * 100.0
  end




end
