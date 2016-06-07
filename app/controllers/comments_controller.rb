class CommentsController < ApplicationController

	before_action :find_msg
	before_action :find_user
	before_action :find_comment, only: [:edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

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

	def edit
	end

	def update
		if @comment.update_attributes(comment_params)
			flash[:success] = "Comment updated!"
			redirect_to @message
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		flash[:success] = "Comment deleted"
		redirect_to @message
	end

	private
	  def comment_params
	  	params.require(:comment).permit(:content)
	  end

	  def find_msg
	  	@message = Message.find(params[:message_id])
	  end

	  def find_user
	  	@user = User.find(@message.user_id)
	  end

	  def find_comment
		@comment = @message.comments.find(params[:id])
	  end
end
