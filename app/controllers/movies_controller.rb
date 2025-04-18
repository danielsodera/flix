class MoviesController < ApplicationController
  
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  
  
  def index
    case params[:filter]
    when "upcoming" 
      @movies = Movie.upcoming
    when "recent"
      @movies = Movie.recent
    when "hits"
      @movies = Movie.hits
    when "flops"
      @movies = Movie.flops
    else
      @movies = Movie.released
    end
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres
    if current_user
      @favourite = current_user.favourites.find_by(movie_id: @movie.id )
    end
  end

  def edit 
  end

  def update 

    if @movie.update(movie_params) === true
      redirect_to @movie, notice: "Event Successfully Updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create 
    @movie = Movie.new(movie_params)
    if @movie.save == true
      redirect_to @movie, notice: "Event Successfully Created!"
    else 
       render :new, status: :unprocessable_entity
    end
  end 

 def destroy 
    @movie.destroy 
    redirect_to root_url, status: :see_other, alert: "Event Successfully Deleted"
  end


private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end 



  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
  end

end
