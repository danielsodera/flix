module ReviewsHelper

  def avg_stars(movie)
    if movie.avg_rating.zero? 
      content_tag(:strong, "No reviews")

    else 
     pluralize(number_with_precision(movie.avg_rating, precision: 1) , "review")
    end
  end
end
