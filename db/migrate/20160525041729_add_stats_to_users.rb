class AddStatsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :hp, :integer, default: 100
   	add_column :users, :mp, :integer, default: 30
  	add_column :users, :str, :integer, default: 10
  	add_column :users, :agi, :integer, default: 10
  	add_column :users, :vit, :integer, default: 10
  	add_column :users, :int, :integer, default: 10
  	add_column :users, :luck, :integer, default: rand(100)
  	add_column :users, :sp, :integer, default: 3
  end
end
