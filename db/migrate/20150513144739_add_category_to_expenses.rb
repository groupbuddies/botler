class AddCategoryToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :category, index: true
    add_foreign_key :expenses, :categories
  end
end
