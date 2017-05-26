class AddNameToEventItem < ActiveRecord::Migration
  def change
    add_column :event_items, :name, :string
  end
end
