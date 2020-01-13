class Community < ApplicationRecord

	has_many :members
	accepts_nested_attributes_for :members
	has_many :users, through: :members

	# 募集中のコミュニティ
	scope :active, -> { where(is_closed: false) }
	# まだ開催されていないコミュニティ
	scope :yet, -> { where(is_held: false) }

	scope :host, -> { where(is_host: true) }

end
