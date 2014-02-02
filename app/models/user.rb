class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  has_many :permissions

  # scope :admins, -> { where(admin: true) }
  # scope :by_name, -> { order(:name) }
end
