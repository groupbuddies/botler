require 'rails_helper'

describe Expense, type: :model do
  context '#name' do
    it 'has a name' do
      expense = build(:expense, name: 'Jantar')

      expect(expense.name).to eq 'Jantar'
    end
  end

  context '#valid?' do
    it 'is valid when all fields are present' do
      expense = build(:expense)

      expect(expense).to be_valid
    end

    it 'must have a value' do
      expense = build(:expense, value: nil)

      expect(expense).not_to be_valid
    end
  end
end
