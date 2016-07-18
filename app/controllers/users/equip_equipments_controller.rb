class Users::EquipEquipmentsController < ApplicationController
    before_action :correct_user,   only: [:update]

    def update
      @user = User.find(params[:id])
      @equipment = Item.find(params[:equipment])
      @body_pt = @equipment.body_pt == "Weapon" ? "wpn" : @equipment.body_pt.to_s.downcase 

      if @equipment.lvl > @user.lvl
      	flash[:danger] = "Your level is not high enough to equip this equipment!"
      elsif @equipment.class_restriction != nil && @equipment.class_restriction.to_i != @user.job_id.to_i
      	flash[:danger] = "You are not of the correct class to use this equipment!"
      else
      	#Unequip item if there's an equipment. 
      	if @user["eqp_" + @body_pt] != nil
      		@equippeditem = Item.find(@user["eqp_" + @body_pt])
      		@user.unequip(@equippeditem)
      	end

      	#Equip item
      	@user.equip(@equipment)
      	flash[:success] = @equipment.name + " successfully equiped!"
      end
      
      redirect_to items_path
    end
end