class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :identity_no
      t.integer :lvl
      t.integer :exp
      t.boolean :admin
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
