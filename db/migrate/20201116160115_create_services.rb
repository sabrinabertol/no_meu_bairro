class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :address
      t.integer :phone
      t.time :time
      t.string :socialmedia
      t.float :latitude
      t.float :longitude
      t.references :neighbourhood, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
