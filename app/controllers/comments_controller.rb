class CommentsController < ApplicationController
	def create
		@message = Message.find(params[:message_id])
		@comment = @message.comments.create(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:success] = "Commented on message!"
			redirect_to @message
		else
			render 'new'
		end
	end

	private
	  def comment_params
	  	params.require(:comment).permit(:content)
	  end
end
