module FavouritesHelper

  def fav_or_unfav(favourite, movie)
    if favourite
        button_to "♥️ unfave", movie_favourite_path(movie, favourite), method: :delete
    else
        button_to "♥️ Fave", movie_favourites_path(movie)
    end
  end



end
