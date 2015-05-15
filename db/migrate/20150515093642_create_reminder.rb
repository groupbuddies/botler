class CreateReminder < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :message
      t.belongs_to :user, index: true
      t.date :due_on
      t.belongs_to :periodic_expense, index: true
    end
    add_foreign_key :reminders, :users
    add_foreign_key :reminders, :periodic_expenses
  end
end
