class AddCostToEventItems < ActiveRecord::Migration
  def change
    add_column :event_items, :cost, :float
  end
end
