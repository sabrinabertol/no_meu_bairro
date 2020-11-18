class RenameTimeToOpentimeInServices < ActiveRecord::Migration[6.0]
  def change
    rename_column :services, :time, :opentime
  end
end
