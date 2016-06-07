class EditColumnsForQuestsAndQuestAssignments < ActiveRecord::Migration
  def change
  	change_column :quest_assignments, :completed, :boolean, :default => false
  	remove_column :quests, :creator_id
  	remove_column :quests, :completed
  end
end
