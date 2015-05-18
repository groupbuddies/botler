require 'rails_helper'

describe Expense, type: :model do
  context '#description' do
    it 'has a description' do
      expense = build(:expense, description: 'Jantar')

      expect(expense.description).to eq 'Jantar'
    end
  end

  context '#valid?' do
    it 'is valid when all fields are present' do
      expense = build(:expense)

      expect(expense).to be_valid
    end

    it 'must have an amount' do
      expense = build(:expense, amount: nil)

      expect(expense).to be_invalid
    end

    it 'must have a paid on date' do
      expense = build(:expense, paid_on: nil)

      expect(expense).to be_invalid
    end

    context 'paid_on is in the future' do
      it 'is invalid' do
        expense = build(:expense, paid_on: Date.tomorrow)

        expect(expense).to be_invalid
      end
    end
  end
end
