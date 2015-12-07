class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  validates :content, presence: true

  scope :order_by,-> {order created_at: :DESC}
  scope :learn, ->user, category{where "id in (select word_id from results where
    lesson_id in (select id from lessons where user_id = #{user.id})) AND category_id = #{category.id}"}

  scope :not_learn, ->user, category{where "id not in (select word_id from results where
    lesson_id in (select id from lessons where user_id = #{user.id})) AND category_id = #{category.id}"}
end
