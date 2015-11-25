class Answer < ActiveRecord::Base
  has_many :words

  validates :content, presence: true
end
