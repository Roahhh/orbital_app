class ChangeClassNameInUsers < ActiveRecord::Migration
  def change
 	rename_column :users, :class, :class_no
  end
end
