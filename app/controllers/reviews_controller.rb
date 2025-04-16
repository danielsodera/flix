class ReviewsController < ApplicationController

  before_action :set_movie
  before_action :require_signin, except: [:index]

  def index 

    @reviews = @movie.reviews
  end

  def new 

    @review = @movie.reviews.new
  end

  def create 
    
    @review = @movie.reviews.new(review_params)
    @review.user_id = current_user.id
    
    if @review.save == true
      redirect_to movie_reviews_path(@movie), notice: "Review Successfully Added!"
    else 
       render :new, status: :unprocessable_entity
    end

  end 

  private
  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end

end
