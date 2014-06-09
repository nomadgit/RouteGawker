class CreatePromenades < ActiveRecord::Migration
  def change
    create_table :promenades do |t|
      t.string :origin_location
      t.string :destination_location
      t.timestamps
    end
  end
end
