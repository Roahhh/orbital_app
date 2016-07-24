class Mob < ActiveRecord::Base
	def self.up
    create_table :monsters do |t|
      t.string :name
      t.integer :attack
      t.integer :luck
      t.integer :gold
      t.integer :resource_points
      t.integer :max_hp
      t.integer :cur_hp
 
      t.timestamps
    end
  end
end
