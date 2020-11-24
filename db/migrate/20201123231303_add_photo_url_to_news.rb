class AddPhotoUrlToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :photourl, :string
  end
end
