class ChangeLastPaidAtToLastPaidOn < ActiveRecord::Migration
  def change
    remove_column :periodic_expenses, :last_paid_at, :date
    add_column :periodic_expenses, :last_paid_on, :date
  end
end
