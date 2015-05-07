class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :picture, null: false
      t.integer :expense_id, null: false
    end
  end
end
