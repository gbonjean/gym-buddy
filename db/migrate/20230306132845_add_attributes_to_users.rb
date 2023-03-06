class AddAttributesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :address, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :franchise, :string
    add_column :users, :avatar_url, :string
  end
end
