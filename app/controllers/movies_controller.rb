class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  helper_method :bg_color_class
  def bg_color_class(str)
    if params[:order] == str
      'hilite'
    end
  end

  def index
    if params[:order] == "Title"
      @movies = Movie.order(:title)
      #th = hilight or something
    elsif params[:order] == "Date"
      @movies = Movie.order(:release_date)
      #th = hilite
    else
      @movies = Movie.all
    end
    #TODO: fix this
    @all_ratings = ['G','PG','PG-13','R']
    if params["ratings"]  && !params["ratings"].empty?
      @movies = Movie.where(:rating => params["ratings"].keys )
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
