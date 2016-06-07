class MessagesController < ApplicationController
	before_action :logged_in_user
	before_action :find_msg, only: [:show, :edit, :update, :destroy]
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def index
		@messages = Message.all.order("created_at DESC")
	end

	def show
	end

	def new
		@message = current_user.messages.build
	end

	def create
		@message = current_user.messages.build(message_params)

		if @message.save
			flash[:success] = "Message has been successful created!"
			redirect_to @message
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @message.update_attributes(message_params)
			flash[:success] = "Message updated!"
			redirect_to @message    
		else
			render 'edit'
		end
	end

	def destroy
		@message.destroy
		flash[:success] = "Message deleted"
		redirect_to messages_url
	end

	private
	  def message_params
	  	params.require(:message).permit(:title, :description)
	  end

	  def find_msg
		@message = Message.find(params[:id])
	  end

	  def find_user
	  	@user = User.find(@message.user_id)
	  end
end
