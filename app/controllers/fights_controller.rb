class FightsController < ApplicationController
	before_action :logged_in_user
  before_action :qualified_user, only: [:index, :combat]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :create]

  def index
  end

  def combat
  end

  def death
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
end