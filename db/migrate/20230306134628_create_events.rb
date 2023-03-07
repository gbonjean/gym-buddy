class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :gym, null: false, foreign_key: true
      t.integer :slots
      t.text :description
      # t.references :owner, null: false, foreign_key: { to_table: :users }
      t.references :user, null: false, foreign_key: true
      t.boolean :same_level
      t.boolean :musculation
      t.boolean :cardio
      t.boolean :fitness

      t.timestamps
    end
  end
end
