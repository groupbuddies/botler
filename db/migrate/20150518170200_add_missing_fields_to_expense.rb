class AddMissingFieldsToExpense < ActiveRecord::Migration
  def change
    remove_column :expenses, :name, :string
    add_column :expenses, :description, :string
    add_column :expenses, :supplier, :string
    add_column :expenses, :vat, :float
    add_column :expenses, :cost_center, :string
    add_column :expenses, :payment_method, :string
  end
end
