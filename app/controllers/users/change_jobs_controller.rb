class Users::ChangeJobsController < ApplicationController
    before_action :correct_user,   only: [:update]
  # Note that this stats adding is for user to allocate their SP
	def update
		@user = User.find(params[:id])
        @job = Job.find(params[:job_id])
        @clan = @user.clan
        @town = Town.find_by(name: @clan)
        
        if @user.lvl.to_i < @job.lvl.to_i 
        	flash[:danger] = "Your level is not high enough to change into this class!"
        elsif @town.castle_lvl < @job.castle_lvl
        	flash[:danger] = "Your clan's castle does not meet the requirements to grant you this class!"
        else
     	    @user.changejob(params[:job_id])
     	    flash[:success] = "Job changed to " + @job.name.titleize + " successfully!"

     	    #need to unequip all items that cannot be held
     	    if @user.eqp_head != nil
     	    	@head = Item.find(@user.eqp_head)
     	    	@cr = @head.class_restriction

     	    	if @cr == nil 
     	    	elsif @cr.to_i != params[:job_id].to_i
     	    		@user.unequip(@head)
     	    	end
     	    end

     	    if @user.eqp_body != nil
     	    	@body = Item.find(@user.eqp_body)
     	    	@cr = @body.class_restriction

     	    	if @cr == nil 
     	    	elsif @cr.to_i != params[:job_id].to_i
     	    		@user.unequip(@body)
     	    	end
     	    end

     	    if @user.eqp_boots != nil
     	    	@boots = Item.find(@user.eqp_boots)
     	    	@cr = @boots.class_restriction

     	    	if @cr == nil 
     	    	elsif @cr.to_i != params[:job_id].to_i
     	    		@user.unequip(@boots)
     	    	end
     	    end

     	    if @user.eqp_wpn != nil
     	    	@wpn = Item.find(@user.eqp_wpn)
     	    	@cr = @wpn.class_restriction

     	    	if @cr == nil 
     	    	elsif @cr.to_i != params[:job_id].to_i
     	    		@user.unequip(@wpn)
     	    	end
     	    end
     	end

        redirect_to castles_path
	end
end