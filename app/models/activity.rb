class Activity < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :activity, presence: true

  scope :order_by,-> {order created_at: :DESC}
end
