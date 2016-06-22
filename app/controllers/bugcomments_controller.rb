class BugcommentsController < ApplicationController

	before_action :find_bugreport
	before_action :find_user
	before_action :find_bugcomment, only: [:edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def create
		@bugcomment = @bugreport.bugcomments.create(bugcomment_params)
		@bugcomment.user_id = current_user.id

		if @bugcomment.save
			flash[:success] = "Commented on Bug Report!"
			redirect_to @bugreport
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @bugcomment.update_attributes(bugcomment_params)
			flash[:success] = "Comment updated!"
			redirect_to @bugreport
		else
			render 'edit'
		end
	end

	def destroy
		@bugcomment.destroy
		flash[:success] = "Comment deleted"
		redirect_to @bugreport
	end

	private
	  def bugcomment_params
	  	params.require(:bugcomment).permit(:content)
	  end

	  def find_bugreport
	  	@bugreport = Bugreport.find(params[:bugreport_id])
	  end

	  def find_user
	  	@user = User.find(@bugreport.user_id)
	  end

	  def find_bugcomment
		@bugcomment = @bugreport.bugcomments.find(params[:id])
	  end

end
