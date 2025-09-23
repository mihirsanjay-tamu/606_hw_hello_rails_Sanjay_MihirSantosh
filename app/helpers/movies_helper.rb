module MoviesHelper
  def sorted_class(column)
    current_sort = params[:sort] || session[:sort] || "title"
    current_direction = params[:direction] || session[:direction] || "asc"

    if current_sort == column
      current_direction == "asc" ? "sorted-asc" : "sorted-desc"
    else
      ""
    end
  end


  def sorted_symbol(column)
    current_sort = params[:sort] || session[:sort] || "title"
    current_direction = params[:direction] || session[:direction] || "asc"

    if current_sort == column
      current_direction == "asc" ? "▲" : "▼" # Up or down arrow
    else
      ""
    end
  end
end
