class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :periodic_expense

  validates :name, :user, :amount, presence: true
end
