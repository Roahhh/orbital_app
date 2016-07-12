class ItemassignmentsController < ApplicationController
	def create
		@user = User.find(params[:user_id])
		@itemassignment = ItemAssignment.find_by(item_id: params[:item_id], user_id: params[:user_id])
		@totalcost = params[:quantity].to_i * params[:cost].to_i

		if @totalcost > @user.gold_pts
			flash[:danger] = "Insufficient Gold to make purchase!"
		elsif @itemassignment == nil
			@itemassignment = ItemAssignment.new(quantity: params[:quantity].to_i, item_id: params[:item_id], user_id: params[:user_id])
			@itemassignment.save

			@user.gold_pts -= @totalcost
			@user.save
		else
			@itemassignment.quantity = @itemassignment.quantity + params[:quantity].to_i
			@itemassignment.save
		end

		if @location = "Item"
			redirect_to item_shops_path
		elsif @location = "Equipment"
		end
	end

	private

end
