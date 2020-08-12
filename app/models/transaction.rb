class Transaction < ApplicationRecord
  validates :name, :amount, presence: true

  belongs_to :user
end
