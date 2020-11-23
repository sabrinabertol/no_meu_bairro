class RemoveFieldNeighbourdFromNews < ActiveRecord::Migration[6.0]
  def change
    remove_reference :news, :neighbourhood, null: false, foreign_key: true
  end
end
