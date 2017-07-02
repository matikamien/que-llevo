class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :item_name
      t.integer :amount

      t.timestamps null: false
    end
  end
end
