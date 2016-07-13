class CreateMobs < ActiveRecord::Migration
  def change
    create_table :mobs do |t|
      t.string :name
      t.string :description
      t.integer :hp
      t.integer :gold
      t.integer :resource_pt
      t.integer :att

      t.timestamps null: false
    end
  end
end
