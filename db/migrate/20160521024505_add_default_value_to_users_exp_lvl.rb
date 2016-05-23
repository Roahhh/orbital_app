class AddDefaultValueToUsersExpLvl < ActiveRecord::Migration
  def change
  	change_column :users, :exp, :integer, :default => 0
  	change_column :users, :lvl, :integer, :default => 1
  end
end
