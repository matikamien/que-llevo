class CreateEventItems < ActiveRecord::Migration
  def change
    create_table :event_items do |t|
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
