class Expense < ActiveRecord::Base
  belongs_to :user

  validates :name, :user, :value, presence: true
end
