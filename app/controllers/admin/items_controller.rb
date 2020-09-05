class Admin::ItemsController < ApplicationController
	before_action :authenticate
	def index
		# indexでは一覧を表示するため
		# インスタンス変数kitemsにItemモデルの中にあるすべてののデータをを代入
		@items = Item.all
	end

	def new
		# form_forヘルパーで入力されたデータを格納する空のItemモデルを作成する
		# それをインスタンス変数に代入する
		@item = Item.new
	end

	def create
		# newアクションで入力されたデータをこのItem.newにいれてストロングパロメータに送信される
		@item = Item.new(item_params)
		# saveメソッドで@Itemに入っているデータをデータベースに保存する
		# 保存できない場合はfalseが返る
		if @item.save
		 # binding.pry
		redirect_to admin_item_path(@item.id)
		else
		 render :new
		end
	end

	def show
		@item = Item.find(params[:id])
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		@item.update(item_params)
		redirect_to admin_items_path
	end

	private
	def item_params
		params.require(:item).permit(:genre_id, :name, :introduction, :price, :image, :is_active)
	end
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end

end
