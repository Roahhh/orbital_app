class QuestsController < ApplicationController
	before_action :logged_in_user
	before_action :admin_user, only: [:new, :create] 

	def new
		@quest = Quest.new
	end

	def create
		@quest = current_user.quests.build(quest_params)
		@quest.user_id = current_user.id

		params[:quest_assignment][:user_id].each do |user_id|
			if user_id == ""
			else
				@quest.quest_assignments.build(:user_id => user_id)
			end
		end

		if @quest.save
			flash[:success] = "Quest successfully created!"
			redirect_to current_user
		else
			render 'new'
		end

	end

	def show
		@quest = Quest.find(params[:id])
		@questassignments =  QuestAssignment.where(quest_id: params[:id])
	end

	private
		def quest_params
			params.require(:quest).permit(:quest_type, :title, :description, :deadline)
		end
end
