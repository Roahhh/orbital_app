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
end