class CreateNeighbourhoods < ActiveRecord::Migration[6.0]
  def change
    create_table :neighbourhoods do |t|
      t.string :name
      t.string :city
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
