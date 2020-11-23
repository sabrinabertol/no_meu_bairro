module ApplicationHelper


  def toggle_favourite(neighbourhood, service)
    # If the task has been favorited...
    if service.favourite
      # Show the ★ and link to "unfavorite" it
      link_to raw("<i class='fa fa-heart favourite'></i>"), neighbourhood_service_favourite_path(neighbourhood, service), method: :delete
    else
      # Show the ☆ and link to "favorite" it
      link_to raw("<i class='far fa-heart'></i>"), neighbourhood_service_favourite_path(neighbourhood, service), method: :post
    end
  end


end
