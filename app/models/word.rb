class Word < ActiveRecord::Base
  require "csv"
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers
  validates :content, presence: true

  scope :order_by,-> {order created_at: :DESC}
  scope :learn, ->user, category{where "id in (select word_id from results where
    lesson_id in (select id from lessons where user_id = #{user.id})) AND category_id = #{category.id}"}

  scope :not_learn, ->user, category{where "id not in (select word_id from results where
    lesson_id in (select id from lessons where user_id = #{user.id})) AND category_id = #{category.id}"}

  class << self
    def import file
      CSV.foreach(file.path, headers: true) do |row|
        word_hash = row.to_hash
        word=Word.where(content: word_hash["content_word"])
        if word.count == 0
          user=Word.create! content: word_hash["content_word"], category_id: word_hash["category_id"]
          if !user.nil?
            Answer.create! content: word_hash["content_answer1"], correct: word_hash["correct1"], word_id: user.id
            Answer.create! content: word_hash["content_answer2"], correct: word_hash["correct2"], word_id: user.id
            Answer.create! content: word_hash["content_answer3"], correct: word_hash["correct3"], word_id: user.id
            Answer.create! content: word_hash["content_answer4"], correct: word_hash["correct4"], word_id: user.id
          end
        end
      end
    end
  end
end
