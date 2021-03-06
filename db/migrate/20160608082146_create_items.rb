class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :shop
      t.string :name
      t.string :description
      t.integer :lvl, :default => 1
      t.integer :hp, :default => 0
      t.integer :mp, :default => 0
      t.integer :str, :default => 0
      t.integer :agi, :default => 0
      t.integer :vit, :default => 0
      t.integer :int, :default => 0
      t.integer :rec_hp, :default => 0
      t.integer :rec_mp, :default => 0
      t.integer :cost, :default => 0
      t.string :class_restriction
      t.string :body_pt

      t.timestamps null: false
    end
  end
end
