class ChangeTypeNameInItems < ActiveRecord::Migration
  def change
  	rename_column :items, :type, :shop
  end
end
