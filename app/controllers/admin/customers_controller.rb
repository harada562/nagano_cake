class Admin::CustomersController < ApplicationController
	before_action :authenticate
	def index
		# Customerモデルの中のデータをすべて代入する
		@customers = Customer.all
	end

	def show
		# indexで会員idを持たせてshowに移動している
		# その会員idのデータを見つける(findメソッドで)
		# params[:id]でデータベースから持たされたidのレコードを取得する
		@customer = Customer.find(params[:id])
	end

	def edit
		@customer = Customer.find(params[:id])
	end

	def update
		@customer = Customer.find(params[:id])
		@customer.update(customer_params)
		redirect_to admin_customer_path
	end
	private
	def customer_params
		params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
	end
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
