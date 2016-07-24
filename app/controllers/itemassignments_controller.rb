class ItemassignmentsController < ApplicationController
	before_action :logged_in_user

	def create
		@user = User.find(params[:user_id])
		@itemassignment = ItemAssignment.find_by(item_id: params[:item_id], user_id: params[:user_id])
		@totalcost = params[:quantity].to_i * params[:cost].to_i

		if @totalcost > @user.gold_pts
			flash[:danger] = "Insufficient Gold to make purchase!"
		elsif @itemassignment == nil
			flash[:success] = "Purchased " + params[:quantity].to_s + "x " + Item.find(params[:item_id]).name 
			@itemassignment = ItemAssignment.new(quantity: params[:quantity].to_i, item_id: params[:item_id], user_id: params[:user_id])
			@itemassignment.save

			@user.gold_pts -= @totalcost
			@user.save
		else
			flash[:success] = "Purchased " + params[:quantity].to_s + "x " + Item.find(params[:item_id]).name 
			@itemassignment.quantity += params[:quantity].to_i
			@itemassignment.save

			@user.gold_pts -= @totalcost
			@user.save
		end

		if params[:location] == "Item"
			redirect_to item_shops_path
		elsif params[:location] == "Equipment"
			redirect_to eq_shops_path
		else
			flash[:danger] = "Error with purchase"
			redirect_to towns_path
		end
	end

	private

end
