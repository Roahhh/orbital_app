class Users::AddStatsController < ApplicationController
    before_action :correct_user,   only: [:update]
  # Note that this stats adding is for user to allocate their SP
	def update
		@user = User.find(params[:id])
		if @user.sp <= 0 
        	flash[:danger] = "Not enough SP!"
        	redirect_to @user
        else
        	@user.add_stat(params[:stat])
        	flash[:success] = @user.stat_long(params[:stat]) + " has been successfully added!"
        	redirect_to @user
        end
	end

	private
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