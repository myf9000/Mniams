class AddMovieToMniams < ActiveRecord::Migration
  def change
    add_column :mniams, :movie, :string
  end
end
