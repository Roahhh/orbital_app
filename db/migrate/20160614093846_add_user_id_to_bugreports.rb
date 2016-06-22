class AddUserIdToBugreports < ActiveRecord::Migration
  def change
  	add_column :bugreports, :user_id, :integer
  end
end
