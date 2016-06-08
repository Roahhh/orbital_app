class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :name
      t.integer :item_lvl, :default => 1
      t.integer :item_exp, :default => 0
      t.integer :eqp_lvl, :default => 1
      t.integer :eqp_exp, :default => 0
      t.integer :castle_lvl, :default => 1
      t.integer :castle_exp, :default => 0

      t.timestamps null: false
    end
  end
end
