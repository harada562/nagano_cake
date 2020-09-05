class Public::ItemsController < ApplicationController
	def top
	end

	def index
		@items = Item.all
	end

	def show
		@items = CartItem.new
		@item = Item.find(params[:id])
		@customer = current_customer
	end
end
