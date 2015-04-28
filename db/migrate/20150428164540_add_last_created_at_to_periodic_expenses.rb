class AddLastCreatedAtToPeriodicExpenses < ActiveRecord::Migration
  def change
    add_column :periodic_expenses, :last_created_at, :date
  end
end
