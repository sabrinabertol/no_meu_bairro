class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.text :content
      t.references :neighbourhood, null: false, foreign_key: true

      t.timestamps
    end
  end
end
