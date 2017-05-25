class CreateJoinTableUserEvent < ActiveRecord::Migration
  def change
    create_join_table :Users, :Events do |t|
      # t.index [:user_id, :event_id]
      # t.index [:event_id, :user_id]
    end
  end
end
