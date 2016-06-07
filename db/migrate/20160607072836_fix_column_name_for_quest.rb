class FixColumnNameForQuest < ActiveRecord::Migration
  def change
  	rename_column :quests, :type, :quest_type
  end
end
