class CreateUserDisciplines < ActiveRecord::Migration[7.0]
  def change
    create_table :user_disciplines do |t|
      t.references :discipline, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
