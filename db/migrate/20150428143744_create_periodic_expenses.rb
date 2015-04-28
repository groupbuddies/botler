class CreatePeriodicExpenses < ActiveRecord::Migration
  def change
    create_table :periodic_expenses do |t|
      t.string :name
      t.float :amount
      t.string :period
      t.integer :user_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
