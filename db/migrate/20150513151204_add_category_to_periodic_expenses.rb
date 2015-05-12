class AddCategoryToPeriodicExpenses < ActiveRecord::Migration
  def change
    add_reference :periodic_expenses, :category, index: true
    add_foreign_key :periodic_expenses, :categories
  end
end
