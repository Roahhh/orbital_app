class AddBonusStatsJobClanToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :hp_job, :integer, default: 0
   	add_column :users, :mp_job, :integer, default: 0
  	add_column :users, :str_job, :integer, default: 0
  	add_column :users, :agi_job, :integer, default: 0
  	add_column :users, :vit_job, :integer, default: 0
  	add_column :users, :int_job, :integer, default: 0
  	add_column :users, :hp_eqp, :integer, default: 0
   	add_column :users, :mp_eqp, :integer, default: 0
  	add_column :users, :str_eqp, :integer, default: 0
  	add_column :users, :agi_eqp, :integer, default: 0
  	add_column :users, :vit_eqp, :integer, default: 0
  	add_column :users, :int_eqp, :integer, default: 0
  	add_column :users, :job, :string, default: "Apprentice"
  	add_column :users, :clan, :string, default: "Neutral"
  end
end
