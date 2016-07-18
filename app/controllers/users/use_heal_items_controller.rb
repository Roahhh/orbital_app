class Users::UseHealItemsController < ApplicationController
    before_action :correct_user,   only: [:update]

    def update
      @user = User.find(params[:id])
      @item = Item.find(params[:item_id])
      @itemassignment = ItemAssignment.find_by(user_id: params[:id], item_id: params[:item_id])

      if @itemassignment.blank?
        flash[:danger] = 'You cannot use an item that you do you have!'
      else 

        if @user.curr_hp + @item.rec_hp > @user.total_stat('hp') 
          @user.curr_hp = @user.hp
        else 
          @user.curr_hp += @item.rec_hp
        end

        if @user.curr_mp + @item.rec_mp > @user.total_stat('mp')
          @user.curr_mp = @user.mp
        else
          @user.curr_mp += @item.rec_mp
        end

        if @itemassignment.quantity == 1
          @itemassignment.destroy
        else
          @itemassignment.quantity -= 1
          @itemassignment.save
        end

        @user.save
        flash[:success] = @item.name + " used!"
      end

      redirect_to items_path

    end
end