class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true

  belongs_to :user
  has_many :transactions
end
