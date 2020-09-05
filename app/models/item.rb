class Item < ApplicationRecord
	# genreに一つのデータを送信可能
	belongs_to :genre
	# cart_itemsに多数のデータを送信可能
	has_many :cart_items, dependent: :destroy
	# order_ditailsに多数のデータを送信可能
	has_many :order_details, dependent: :destroy

	# 画像をアップロードするためのattachementメソッドです
	# imageカラムでアップロード可能にしている
	attachment :image
	# validates :name, presence: true
	# validates :introduction, presence: true
	# validates :price, presence: true
	enum is_active: { 販売停止中:0, 販売中:1 }

	 def self.search(search)
      if search
        Item.where(['name LIKE ?', "%#{search}%"])
      else
        Item.all
      end
    end
end
