class AddNameAndDescriptiontoMob < ActiveRecord::Migration
  def change
 	add_column :mobs, :name, :string
 	add_column :mobs, :description, :string
  end
end
