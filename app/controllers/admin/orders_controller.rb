class Admin::OrdersController < ApplicationController
before_action :authenticate
	def top
	end

	def index
		@orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		@order.update(update_order_params)
		redirect_to admin_order_path(@order.id)
	end
	private
	def order_params
		params.require(:order).permit(
			:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :status,
			order_details_attributes: [:order_id, :item_id, :amount, :price, :make_status])
	end

	def update_order_params
		params.require(:order).permit(
			:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :status)
	end

	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
