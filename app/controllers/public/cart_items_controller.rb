class Public::CartItemsController < ApplicationController
	before_action :authenticate
	def index
		@carts = current_customer.cart_items.all
		@cart = CartItem.new
	end

	def create
		@cart = CartItem.new(cart_params)
		@cart.save
		redirect_to public_cart_items_path
	end

	def update
		@cart = CartItem.find(params[:id])
		@cart.update(cart_params)
		redirect_to public_cart_items_path
	end

	def destroy
		# カート内商品の削除
		@cart_item = CartItem.find(params[:id])
      	@cart_item.destroy
      	redirect_to public_items_path
	end

	def destroy_all #カート消去
    current_customer.cart_items.destroy_all
    redirect_to root_path
    flash[:info] = 'カートを空にしました。'
  end

	private
	def cart_params
		params.require(:cart_item).permit(:item_id, :customer_id, :amount)
	end
	# customerがログインしていない場合はlogginページに遷移
	def authenticate
  		redirect_to customer_session_path unless customer_signed_in?
	end
end
