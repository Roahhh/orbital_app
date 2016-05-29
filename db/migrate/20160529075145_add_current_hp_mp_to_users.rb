class AddCurrentHpMpToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :curr_hp, :integer, default: 100
   	add_column :users, :curr_mp, :integer, default: 30
  end
end
