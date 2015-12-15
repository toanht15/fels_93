class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results

  accepts_nested_attributes_for :results, allow_destroy: true

  validates :user_id, presence: true
  validates :category_id, presence: true

  before_create :get_words
  after_update :save_activity

  private
  def get_words
    words = category.words.order("RANDOM()").limit(10)
    words.each{|word| results.build word: word}
  end

  def save_activity
    Activity.create! user_id: user_id, target_id: category_id
  end
end
