class Reminder < ActiveRecord::Base
  belongs_to :user
  belongs_to :periodic_expense

  validates :message, :due_on, :user, :periodic_expense, presence: true
end
