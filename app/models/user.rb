class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# ポジション情報
  enum position: {前衛:1, 後衛:2, どちらでも:3, わからない:4}
# 技術レベル
  enum level: {初心者:1, ブランク長め:2, まあまあ:3, 得意:4}
end
