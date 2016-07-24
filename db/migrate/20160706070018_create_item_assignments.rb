class CreateItemAssignments < ActiveRecord::Migration
  def change
    create_table :item_assignments do |t|
      t.integer :quantity
      t.integer :item_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
