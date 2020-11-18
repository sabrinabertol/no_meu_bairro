class RenameSocialmediaToWebsiteInServices < ActiveRecord::Migration[6.0]
  def change
    rename_column :services, :socialmedia, :website
  end
end
