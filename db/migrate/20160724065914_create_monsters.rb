class CreateMonsters < ActiveRecord::Migration
  def self.up
    create_table :monsters do |t|
      t.string :name
      t.integer :attack
      t.integer :max_hp
      t.integer :cur_hp
      t.integer :r_points
      t.string :description
      t.integer :gold
      t.timestamps null: false
    end
  

  Monster.create(:name => 'Goblin', :attack => 10, :description => 'The greatest challenge, every new adventurer has to face', 
      :max_hp => 80, :cur_hp => 80, :gold => 5, :r_points => 3)
  Monster.create(:name => 'Slime', :attack => 6, :description => 'The failed experiments of a bored alchemist from a long time ago', 
      :max_hp => 50, :cur_hp => 50, :gold => 3, :r_points => 1)
  Monster.create(:name => 'Undead Ghoul', :attack => 10, :description => 'Once alive, it now prowls the land seeking its past... and delicious brains', 
      :max_hp => 100, :cur_hp => 100, :gold => 5, :r_points => 6)
  Monster.create(:name => "Small Faerie", :attack => 20, :description => 'Magical beings borne out of the forest',
      :max_hp => 60, :cur_hp => 60, :gold => 10, :r_points => 12)



  end
  def self.down
    drop_table :monsters
  end

end
