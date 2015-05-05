class AddPeriodicExpenseToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :periodic_expense, index: true
    add_foreign_key :expenses, :periodic_expenses
  end
end
