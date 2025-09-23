class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # Make sorting helpers available in views
  helper_method :sort_column, :sort_direction, :toggle_direction


  # GET /movies or /movies.json
  def index
    # Store the current sort in session
    session[:sort] = params[:sort] if params[:sort]
    session[:direction] = params[:direction] if params[:direction]

    # Use params first, fallback to session
    sort_col = params[:sort] || session[:sort] || "title"
    sort_dir = params[:direction] || session[:direction] || "asc"

    @movies = Movie.order("#{sort_col} #{sort_dir}")
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movies_path(sort: session[:sort], direction: session[:direction]), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movies_path(sort: session[:sort], direction: session[:direction]), notice: "Movie was successfully created." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path(sort: session[:sort], direction: session[:direction]), notice: "Movie was successfully created." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

    # --- Sorting helpers ---
    def sort_column
      %w[title rating release_date].include?(params[:sort]) ? params[:sort] : "title"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
