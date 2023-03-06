class CreateEventDisciplines < ActiveRecord::Migration[7.0]
  def change
    create_table :event_disciplines do |t|
      t.references :event, null: false, foreign_key: true
      t.references :discipline, null: false, foreign_key: true

      t.timestamps
    end
  end
end
