class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :quest_type
      t.string :title
      t.string :description
      t.datetime :deadline
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

  end
end
