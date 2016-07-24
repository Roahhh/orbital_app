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
      :max_hp => 50, :cur_hp => 50, :gold => 2, :r_points => 3)
  Monster.create(:name => 'Hobgoblin', :attack => 10, :description => 'An evolved form of the common goblin, it possesses greater intellect and strength', 
      :max_hp => 80, :cur_hp => 80, :gold => 7, :r_points => 3)
  Monster.create(:name => 'Small Slime', :attack => 6, :description => 'The failed experiments of a bored alchemist from a long time ago', 
      :max_hp => 50, :cur_hp => 50, :gold => 3, :r_points => 1)
  Monster.create(:name => 'Large Slime', :attack => 6, :description => 'The failed experiments of a bored alchemist from a long time ago', 
      :max_hp => 90, :cur_hp => 90, :gold => 7, :r_points => 2)
  Monster.create(:name => 'Undead Ghoul', :attack => 10, :description => 'Once alive, it now prowls the land seeking its past... and delicious brains', 
      :max_hp => 100, :cur_hp => 100, :gold => 5, :r_points => 6)
  Monster.create(:name => "Small Faerie", :attack => 12, :description => 'Magical beings borne out of the forest',
      :max_hp => 60, :cur_hp => 60, :gold => 10, :r_points => 12)
  Monster.create(:name => "Faerie Warrior", :attack => 20, :description => 'Magical beings borne out of the forest, this one has trained well',
      :max_hp => 100, :cur_hp => 100, :gold => 20, :r_points => 12)
  Monster.create(:name => 'Disgruntled User', :attack => 10, :description => 'A User that is currently going through levelling hell',
      :max_hp => 100, :cur_hp => 100, :gold => 10, :r_points => 20)
  Monster.create(:name => 'Hero Wannabe', :attack => 15, :description => 'A person inspired by a strong sense of justice',
      :max_hp => 80, :cur_hp => 80, :gold => 10, :r_points => 20)
  Monster.create(:name => 'Kobold', :attack => 8, :description => 'A subhuman species known for their intellect but small stature',
      :max_hp => 60, :cur_hp => 60, :gold => 7, :r_points => 5)
  Monster.create(:name => 'Troll', :attack => 20, :description => 'A monstrous giant that strikes fear into the hearts of every beginner',
      :max_hp => 200, :cur_hp => 200, :gold => 50, :r_points => 2)
  Monster.create(:name => 'Wraith of Wealth', :attack => 4, :description => 'The materialization of luck and gold, claim its soul to attain wealth',
      :max_hp => 200, :cur_hp => 200, :gold => 100, :r_points => 20)
  Monster.create(:name => 'Annoying Grass Patch', :attack => 4, :description => 'What did that patch of grass ever do to you?',
      :max_hp => 20, :cur_hp => 20, :gold => 1, :r_points => 1)

  end
  def self.down
    drop_table :monsters
  end

end
