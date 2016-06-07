class Quests::MarkCompleteQuestsController < ApplicationController
    before_action :admin_user,   only: [:update]

    def update
      @user = User.find(params[:user_id])
      @quest = Quest.find(params[:quest_id])
      @questassignment = QuestAssignment.find_by(user_id: params[:user_id],
                                                quest_id: params[:quest_id])
      @questassignment.update_attributes(completed: true)

      @questtype = @quest.quest_type
      if @questtype == "Assignment"
        @user.add_exp(100)
      elsif @questtype == "Event"
        @user.add_exp(1000)
      end

      redirect_to @quest
    end
end