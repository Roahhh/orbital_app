class ChangeDataTypeForIdentityNo < ActiveRecord::Migration
  def change
  	change_column(:users, :identity_no, :string)
  end
end
