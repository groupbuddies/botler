class AddParentToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :category, index: true
    add_foreign_key :categories, :categories
  end
end
