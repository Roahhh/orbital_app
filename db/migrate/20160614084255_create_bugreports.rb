class CreateBugreports < ActiveRecord::Migration
  def change
    create_table :bugreports do |t|
      t.string :title
      t.text :description
      t.boolean :completed, :default => false
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
