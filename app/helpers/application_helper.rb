module ApplicationHelper

  def toggle_favourite(neighbourhood, service, current_user)
    # If the task has been favorited...
    if current_user.has_favourited?(service)
      # Show the ★ and link to "unfavorite" it
      link_to raw("<i class='fa fa-heart favourite'></i>"), unfav_neighbourhood_service_path(neighbourhood, service), :method => :post
    else
      # Show the ☆ and link to "favorite" it
      link_to raw("<i class='far fa-heart'></i>"), fav_neighbourhood_service_path(neighbourhood, service), :method => :post
    end
  end
end