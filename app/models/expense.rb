class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :periodic_expense
  has_one :receipt

  validates :description, :user, :amount, :paid_on, :category, presence: true
  validates :paid_on, date: { before_or_equal_to: proc { Date.today } }
  validates_associated :receipt
end
