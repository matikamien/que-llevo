class AddEventUserToEventItems < ActiveRecord::Migration
  def change
    add_reference :event_items, :event_user, index: true, foreign_key: true
  end
end
