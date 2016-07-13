class CreateQuestAssignments < ActiveRecord::Migration
  def change
    create_table :quest_assignments do |t|
      t.boolean :completed, default: false
      t.integer :quest_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
