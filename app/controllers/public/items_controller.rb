class Public::ItemsController < ApplicationController
	def top
		@item1 = Item.find(1)
		@item2 = Item.find(2)
		@item3 = Item.find(3)
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
