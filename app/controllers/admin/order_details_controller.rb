class Admin::OrderDetailsController < ApplicationController
	before_action :authenticate
	def update
		@detail = OrderDetail.find(params[:id])
		@detail.update(order_detail_params)
		redirect_to admin_order_path(@detail.order.id)
	end

	private
	def order_detail_params
		params.require(:order_detail).permit(
			:order_id, :item_id, :amount, :price, :make_status)
	end
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
