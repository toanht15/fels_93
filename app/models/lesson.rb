class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :categories
  has_many :results, dependent: :destroy
  has_many :words, through: :results

  validates :user_id, presence: true
  validates :category_id, presence: true
end
