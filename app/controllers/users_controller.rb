class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show, :add_str, :add_agi, :add_vit, :add_int]
  before_action :correct_user,   only: [:edit, :update, :add_str, :add_agi, :add_vit, :add_int]
  before_action :admin_user,     only: [:destroy, :create]

  def new
  	@user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    params[:user][:luck] == rand(100)
    params[:user][:admin] == '1' ? @user.admin = true : @user.admin = false

    if @user.save
	    flash[:success] = "New User, " + @user.first_name + " " + @user.last_name + " created!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user    
    else
      render 'edit'
    end
  end

  def add_str
    @user = User.find(params[:id])
    if @user.sp <= 0 
      flash[:danger] = "Not enough SP!"
      redirect_to @user
    elsif @user.update_attributes(str: @user.str + 1, sp: @user.sp - 1)
      flash[:success] = "Strength added!"
      redirect_to @user
    end
  end

  def add_agi
    @user = User.find(params[:id])
    if @user.sp <= 0 
      flash[:danger] = "Not enough SP!"
      redirect_to @user
    elsif @user.update_attributes(agi: @user.agi + 1, sp: @user.sp - 1)
      flash[:success] = "Agility added!"
      redirect_to @user
    end
  end

  def add_vit
    @user = User.find(params[:id])
    if @user.sp <= 0 
      flash[:danger] = "Not enough SP!"
      redirect_to @user
    elsif @user.update_attributes(vit: @user.vit + 1, hp: @user.hp + 50, sp: @user.sp - 1)
      flash[:success] = "Vitality added!"
      redirect_to @user
    end
  end

  def add_int
    @user = User.find(params[:id])
    if @user.sp <= 0 
      flash[:danger] = "Not enough SP!"
      redirect_to @user
    elsif @user.update_attributes(int: @user.int + 1, mp: @user.mp + 5, sp: @user.sp - 1)
      flash[:success] = "Agility added!"
      redirect_to @user
    end
  end  

  private

    def user_params
      params.require(:user).permit(:identity_no, :first_name, :last_name,
                                   :email, :password,
                                   :password_confirmation)
    end
    
    # Before filters
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
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