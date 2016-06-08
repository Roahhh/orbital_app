class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :type
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

      t.timestamps null: false
    end
  end
end
