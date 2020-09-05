class Genre < ApplicationRecord
	# itemsに多数のデータを送信可能にする
	has_many :items, dependent: :destroy
	# enum is_active: { f: false, t: true }
end
