class AddServiceownerToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :serviceowner, :boolean
  end
end
