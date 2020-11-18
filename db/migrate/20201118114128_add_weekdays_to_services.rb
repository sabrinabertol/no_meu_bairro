class AddWeekdaysToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :weekdays, :datetime
  end
end
