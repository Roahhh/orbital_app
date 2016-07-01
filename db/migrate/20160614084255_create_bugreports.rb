class CreateBugreports < ActiveRecord::Migration
  def change
    create_table :bugreports do |t|
      t.string :title
      t.text :description
      t.boolean :completed, :default => false

      t.timestamps null: false
    end
  end
end
