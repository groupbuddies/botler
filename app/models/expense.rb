class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :periodic_expense
  has_one :receipt

  validates :name, :user, :amount, presence: true
end
