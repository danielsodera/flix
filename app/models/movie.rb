class Movie < ApplicationRecord

  before_save :set_slug

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy 
  has_many :favourites, dependent: :destroy
  has_many :fans, through: :favourites, source: :user 
  has_many :characterizations, dependent: :destroy 
  has_many :genres, through: :characterizations

  validates :title, presence: true
  validates :released_on, :duration, presence: true 
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  } 

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :rating, inclusion: { in: RATINGS}

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(max=5) { released.limit(max) } 
  scope :hits, -> { released.where("total_gross > ?", 300_000_000).order(total_gross: :desc) }
  scope :flops, -> { released.where("total_gross < ?", 300_000_000).order(total_gross: :asc) }
  scope :recently_added, -> { order(created_at: :desc).limit(3) }

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

  def avg_rating 
    reviews.average(:stars) || 0.0
  end 

  def avg_rating_percent
    (avg_rating/5.0) * 100.0
  end 

  def to_param
    slug
  end

  private 
    def set_slug
      self.slug = title.parameterize
    end

end
