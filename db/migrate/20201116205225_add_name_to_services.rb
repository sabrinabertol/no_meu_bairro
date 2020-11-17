class AddNameToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :name, :string
  end
end
