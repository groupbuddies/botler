class AddLastCreatedAtToPeriodicExpenses < ActiveRecord::Migration
  def change
    add_column :periodic_expenses, :last_created_at, :datetime
  end
end
