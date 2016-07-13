class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :description
      t.integer :castle_lvl, :default => 1
      t.integer :lvl, :default => 1
      t.integer :hp, :default => 0
      t.integer :mp, :default => 0
      t.integer :str, :default => 0
      t.integer :agi, :default => 0
      t.integer :vit, :default => 0
      t.integer :int, :default => 0
      t.integer :luck, :default => 0
      t.integer :hp_bonus, :default => 0
      t.integer :mp_bonus, :default => 0
      t.integer :str_bonus, :default => 0
      t.integer :agi_bonus, :default => 0
      t.integer :vit_bonus, :default => 0
      t.integer :int_bonus, :default => 0
      t.boolean :hidden, :default => false

      t.timestamps null: false
    end
  end
end
