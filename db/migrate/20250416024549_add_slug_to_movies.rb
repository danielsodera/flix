class AddSlugToMovies < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :slug, :string
  end
end
