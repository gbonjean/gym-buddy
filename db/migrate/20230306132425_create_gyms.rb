class CreateGyms < ActiveRecord::Migration[7.0]
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :address
      t.string :franchise
      t.string :logo
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
