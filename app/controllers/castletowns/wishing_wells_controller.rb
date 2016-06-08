class Castletowns::WishingWellsController < ApplicationController
	before_action :logged_in_user, only: [:index, :wish]

  def index
  end

  def wish
  	@user = current_user
    #@current_gold = current_user.find(params[:gold])
		#if gold >= 100
			@user.roll_luck
			@new_luck = @user.luck
			flash[:success] = "The well has changed your fate, your luck is now " + @new_luck.to_s + "."
		#else
			#flash[:failure] = "Insufficient gold. 100 gold is required"
	
  end
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end
end
