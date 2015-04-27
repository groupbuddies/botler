class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.float :value
      t.datetime :date
      t.timestamps
    end
  end
end
