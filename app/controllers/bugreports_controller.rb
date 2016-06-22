class BugreportsController < ApplicationController
	before_action :logged_in_user
	before_action :find_bugreport, only: [:show, :edit, :update, :destroy]
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def index
		@bugreports = Bugreport.all.order("created_at DESC")
	end

	def show
	end

	def new
		@bugreport = current_user.bugreports.build
	end

	def create
		@bugreport = current_user.bugreports.build(bugreport_params)

		if @bugreport.save
			flash[:success] = "Bug successful reported!"
			redirect_to @bugreport
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @bugreport.update_attributes(bugreport_params)
			flash[:success] = "Bug Report updated!"
			redirect_to @bugreport    
		else
			render 'edit'
		end
	end

	def destroy
		@bugreport.destroy
		flash[:success] = "Message deleted"
		redirect_to messages_url
	end

	private
	  def bugreport_params
	  	params.require(:bugreport).permit(:title, :description)
	  end

	  def find_bugreport
		@bugreport = Bugreport.find(params[:id])
	  end

	  def find_user
	  	@user = User.find(@bugreport.user_id)
	  end
end