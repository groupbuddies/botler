class AddReminderToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :reminder, index: true
    add_foreign_key :expenses, :reminders
  end
end
