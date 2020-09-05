class Public::OrdersController < ApplicationController
	before_action :authenticate
	# before_action :order_page, only: [:new, :confirm]
	def thanks
	end

	def index
		@orders = current_customer.orders
		# @items = @ordre
	end

	def new
		@order = Order.new
		# orderとaddresseの空モデル作成
		# addreseモデルが子モデルになる
		# @order.build_address
		@customer = current_customer
	end

	def confirm
		@order = Order.new(order_params)
		@customer = current_customer
		@add = params[:add].to_i
	    if @add == 1
	          @order.postal_code = current_customer.postal_code
	          @order.address = current_customer.address
	          @order.name = current_customer.first_name + current_customer.last_name
	   elsif @add == 2
	    	  @address = Addresse.find(params[:order][:id])
	          @order.postal_code = @address.postal_code
	          @order.address =  @address.address
	          @order.name =  @address.name
	    elsif @add == 3
	    	@order.postal_code = params[:order][:addresse][:postal_code]
        	@order.address = params[:order][:addresse][:address]
        	@order.name = params[:order][:addresse][:name]
	    end
		return if @order.valid?
		render :new
	end

	def back
		@order = Order.new(order_params)
		@customer = current_customer
    	render :new
	end


	def create
		@order = Order.new(order_params)
		@add = params[:add].to_i
	    if @add == 1
	          @order.postal_code = current_customer.postal_code
	          @order.address = current_customer.address
	          @order.name = current_customer.first_name + current_customer.last_name
	    elsif @add == 2
	    	  @address = Addresse.find(@order.address)
	          @order.postal_code = @address.postal_code
	          @order.address =  @address.address
	          @order.name =  @address.name
	    elsif @add == 3
	    	@order.postal_code = params[:order][:new_add][:postal_code]
        	@order.address = params[:order][:new_add][:address]
        	@order.name = params[:order][:new_add][:name]
		end
		if Addresse.find_by(address: @order.address).nil?
	        @address = Addresse.new
	        @address.postal_code = @order.postal_code
	        @address.address = @order.address
	        @address.name = @order.name
	        @address.customer_id = current_customer.id
	        @address.save
      	end

		current_customer.cart_items.each do |cart_item|
			order_detail = @order.order_details.build
			order_detail.order_id = @order.id
			order_detail.item_id = cart_item.item_id
			order_detail.amount = cart_item.amount
			order_detail.price = cart_item.item.price
			order_detail.save
			cart_item.destroy #order_itemに情報を移したらcart_itemは消去
		end
		@order.save
		redirect_to complete_public_orders_path
	end

	def show
		@order = Order.find(params[:id])
	end
	def complete
	end
	private
	def order_params
		params.require(:order).permit(
			:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :status,
			order_details_attributes: [:order_id, :item_id, :amount, :price, :make_status])
	end
	# customerがログインしていない場合はlogginページに遷移
	def authenticate
  		redirect_to customer_session_path unless customer_signed_in?
	end
	# def order_page
	# 	@carts = current_customer.cart_items.ids
	# 	if @carts.ids.empty?
	# 		public_items_path
	# 	end
	# end
end