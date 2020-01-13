class Member < ApplicationRecord
	belongs_to :user
	belongs_to :community

	# コミュニティを作成したユーザー＝ホスト
	scope :host, -> { where(is_host: true) }
end
