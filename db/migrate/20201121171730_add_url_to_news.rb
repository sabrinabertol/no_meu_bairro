class AddUrlToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :url, :string
  end
end
