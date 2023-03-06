class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :end
      t.references :gym, null: false, foreign_key: true
      t.integer :slots
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.boolean :same_level

      t.timestamps
    end
  end
end
