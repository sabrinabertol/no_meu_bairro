class AddFavouriteToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :favourite, :boolean, default: false
  end
end
