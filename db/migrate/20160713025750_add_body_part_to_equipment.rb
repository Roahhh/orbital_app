class AddBodyPartToEquipment < ActiveRecord::Migration
  def change
  	add_column :items, :body_pt, :string
  end
end
