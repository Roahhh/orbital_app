class AddGameColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :title, :string
  	add_column :users, :class, :integer
  	add_column :users, :year, :integer
  	add_column :users, :resource_pts, :integer, :default => 0
  	add_column :users, :gold_pts, :integer, :default => 0
  	add_column :users, :eqp_head, :string
  	add_column :users, :eqp_body, :string
  	add_column :users, :eqp_boots, :string
  	add_column :users, :eqp_wpn, :string
  end
end
