class Admin::GenresController < ApplicationController
	before_action :authenticate
	def index
		# 空のモデルを作成
		@genre = Genre.new
		# genresにGenreモデルの情報すべてを代入
		@genres = Genre.all
	end

	def create
		# genreに空のGenreモデルを作成しその中にはindexで入力されたデータが入る
		# そしてストロングパロメータに送信される
		@genre = Genre.new(genre_params)
		# 入力されたデータをsaveメソッドで、DBに保存する
		@genre.save
		
		redirect_to admin_genres_path
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		@genre.update(genre_params)
        redirect_to admin_genres_path

	end

	private
	def genre_params
		params.require(:genre).permit(:name, :is_active)
	end
	def authenticate
  		redirect_to admin_session_path unless admin_signed_in?
	end
end
