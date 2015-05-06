class ChangeExpenseDateToPaidOn < ActiveRecord::Migration
  def change
    remove_column :expenses, :date, :datetime
    add_column :expenses, :paid_on, :date
  end
end
