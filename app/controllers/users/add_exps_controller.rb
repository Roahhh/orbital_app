class Users::AddExpsController < ApplicationController
    before_action :correct_user,   only: [:update]

    def update
      @user = User.find(params[:id])
      @user.add_exp(params[:exp_add].to_i)
      redirect_to @user
    end

    private
    # Before filters      
    # Confirms the correct user.
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user) || current_user.admin?
      end
end