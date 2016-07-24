class Monster < ActiveRecord::Base



	def self.random_encounter
	offset = rand(Monster.count)
  random_monster = Monster.offset(offset).first
 
  # We'll set the number of hitpoints for the monster to the max before unleashing
  # the freshly retrieved creature out on the world. Note, this is just a copy
  # of the database record. There could be dozens of these in the system all at
  # the same time. As long as none of them is saved back to the database each one
  # can be changed independently (e.g. taking damage), because you're only changing
  # the in-memory copy.
  random_monster.cur_hp = random_monster.max_hp
 
  random_monster
	end

end
