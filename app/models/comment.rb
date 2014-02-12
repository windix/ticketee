class Comment < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :ticket
  belongs_to :user
end
