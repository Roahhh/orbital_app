class CreateConvomessages < ActiveRecord::Migration
  def change
    create_table :convomessages do |t|
      t.text :body
      t.references :conversation, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
