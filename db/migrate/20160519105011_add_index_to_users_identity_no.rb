class AddIndexToUsersIdentityNo < ActiveRecord::Migration
  def change
  	add_index :users, :identity_no, unique: true
  end
end
