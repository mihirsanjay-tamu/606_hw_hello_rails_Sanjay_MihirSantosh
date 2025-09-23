module MoviesHelper
  def toggle_direction(column)
    # Use params first, fallback to session
    current_sort = params[:sort] || session[:sort] || "title"
    current_direction = params[:direction] || session[:direction] || "asc"

    if current_sort == column
      current_direction == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end
end
