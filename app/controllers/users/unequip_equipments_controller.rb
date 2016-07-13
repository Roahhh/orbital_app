class Users::UnequipEquipmentsController < ApplicationController
    before_action :correct_user,   only: [:update]

    def update
      @user = User.find(params[:id])
      @equipment = Item.find(params[:equipment])
      @body_pt = @equipment.body_pt == "Weapon" ? "wpn" : @equipment.body_pt.downcase 
      @equippeditem = Item.find(@user["eqp_" + @body_pt])

      #Unequip item if there's an equipment. 
      if @equippeditem != @equipment
        flash[:danger] = "You are not equipped with this item!"
      elsif @equippeditem == nil
        flash[:danger] = "You can't unequip nothing!"
      else
        @user.unequip(@equippeditem)
        flash[:success] = @equipment.name + " successfully unequiped!"
      end
      
      redirect_to items_path
    end
end