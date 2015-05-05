class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :periodic_expense

  validates :name, :user, :value, presence: true
end
