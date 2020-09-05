class Public::CustomersController < ApplicationController
	before_action :authenticate
	def show
		@customer = current_customer
	end

	def edit
		@customer = current_customer
	end

	def update
		@customer = current_customer
		@customer.update(customer_params)
		redirect_to public_customer_path
	end

	def confrim
		@customer = current_customer
	end

	def hide
        @customer = Customer.find(params[:id])
        #is_deletedカラムにフラグを立てる(defaultはfalse)
        @customer.update(is_deleted: true)
        #ログアウトさせる
        reset_session
        redirect_to root_path
    end
	def customer_params
		params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
	end
	# customerがログインしていない場合はlogginページに遷移
	def authenticate
  		redirect_to customer_session_path unless customer_signed_in?
	end
end
