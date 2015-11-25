class Word < ActiveRecord::Base
  belongs_to :category
  belongs_to :answer

  validates :content, presence: true
end
