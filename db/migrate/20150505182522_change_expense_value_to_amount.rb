class ChangeExpenseValueToAmount < ActiveRecord::Migration
  def change
    remove_column :expenses, :value, :float
    add_column :expenses, :amount, :float
  end
end
