class OrderDetail < ApplicationRecord
	# 注文を保存するため
	belongs_to :order
	# 注文itemを保存するため
	belongs_to :item
	enum make_status: {
		制作不可:0,
		制作待ち:1,
		制作中:2,
		制作完了:3,
	}
	# 空白NG
	validates :item_id, presence: true
end
