class Ticket < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

  belongs_to :project
  belongs_to :user

  NUM_OF_ASSETS = 3

  has_many :assets
  accepts_nested_attributes_for :assets
end
