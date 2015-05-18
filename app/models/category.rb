class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category', foreign_key: 'category_id'
  has_many :subcategories, class_name: 'Category'
  has_many :expenses
  has_many :periodic_expenses

  validates :name, presence: true, uniqueness: true

  scope :main, -> { where(parent: nil) }
  scope :subcategories, -> { where.not(parent: nil) }
end
