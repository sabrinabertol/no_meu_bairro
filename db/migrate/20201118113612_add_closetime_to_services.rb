class AddClosetimeToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :closetime, :time
  end
end
