class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  scope :correct_answer, ->{joins(:answer).where answers: {correct: true}}
end
