# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_558c81314b  (user_id => users.id)
#

class Micropost < ApplicationRecord
  belongs_to :user
  #排序微博
  default_scope -> { order(created_at: :desc) }
  #验证微博的user_id是否存在
  validates :user_id, presence: true

  validates :content, presence: true, lenght: { maximum: 140 }

end
