class Maps::SavageMtsController < ApplicationController
	before_action :logged_in_user
  before_action :qualified_user, only: [:index, :combat]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :create]

  def index
  end

  def combat
  end


  def qualified_user
    unless current_user.lvl > 8 || current_user.admin?
      flash[:danger] = "You do not meet the requirements to access this location."
      redirect_to starts_path
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
