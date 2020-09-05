class Addresse < ApplicationRecord
	belongs_to :customer
	# 空白NG
	validates :address, presence: true
	validates :name, presence: true
	# 文字NG
	validates :postal_code, numericality: true, presence: true
end
