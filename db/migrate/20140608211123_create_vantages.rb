class CreateVantages < ActiveRecord::Migration
  def change
    create_table :vantages do |t|
      t.belongs_to :promenade
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
