class AddClassRestrictiontoItems < ActiveRecord::Migration
  def change
 	add_column :items, :class_restriction, :string
  end
end
