class ConvomessagesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @convomessage = @conversation.convomessages.build(convomessage_params)
    @convomessage.user_id = current_user.id
    @convomessage.save!

    @path = conversation_path(@conversation)
  end

  private

  def convomessage_params
    params.require(:convomessage).permit(:body)
  end
end
