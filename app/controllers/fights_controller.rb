class FightsController < ApplicationController
	before_action :logged_in_user
  before_action :qualified_user, only: [:index, :combat]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :create]

  def index
     flash[:danger] = random_message
  end

  def combat
  end

  def death
    flash[:danger] = death_message
  end

  def drops
  end



  def qualified_user
  	#user.runs > 0
  	store_location
    unless current_user.hp > 0 || current_user.admin?

      if current_user.hp == 0
			  flash[:danger] = "You do not have sufficient HP"

      end
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
  end

  def only_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private

  def random_message
    @messages = ["A devilish presence has appeared", "You sense a hostile intent directed towards you", "You stumbled across the path of a wandering monster"]
    return @messages.sample
  end

  def death_message
    @death_messages = ["You have been slain in battle", "Thou hath died a gruesome death", "Your vision becomes enshrouded with darkness", "The reaper claims your soul"]
    return @death_messages.sample
  end  
end
