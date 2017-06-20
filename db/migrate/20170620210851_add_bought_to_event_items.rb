class AddBoughtToEventItems < ActiveRecord::Migration
  def change
    add_column :event_items, :bought, :boolean, :default => false
  end
end
