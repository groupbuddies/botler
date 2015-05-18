class AddMissingFieldsToPeriodicExpense < ActiveRecord::Migration
  def change
    remove_column :periodic_expenses, :name, :string
    add_column :periodic_expenses, :description, :string
    add_column :periodic_expenses, :supplier, :string
    add_column :periodic_expenses, :vat, :float
    add_column :periodic_expenses, :cost_center, :string
    add_column :periodic_expenses, :payment_method, :string
  end
end
