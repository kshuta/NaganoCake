class Admin::GenresController < ApplicationController
  def index
    @new_genre = Genre.new()
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    genre = Genre.new(genre_params)
    genre.is_activated = params[:is_activated]
    if genre.save
      redirect_to admin_genres_path
    else
      @new_genre = genre
      @genres = Genre.all
      render :index
    end
  end

  def update
    genre = Genre.find(params[:id])
    genre.is_activated = params[:is_activated]
    if genre.update(genre_params)
      redirect_to admin_genres_path
    else
      @genre = genre 
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_activated)
  end
end
