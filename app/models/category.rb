class Category < ActiveRecord::Base
  has_many :expenses
  has_many :periodic_expenses

  validates :name, presence: true, uniqueness: true
end
