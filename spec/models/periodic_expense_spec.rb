require 'rails_helper'

describe PeriodicExpense, type: :model do
  context '#valid?' do
    it 'is valid when all fields are present' do
      periodic_expense = build(:periodic_expense)

      expect(periodic_expense).to be_valid
    end

    it 'must have a valid period' do
      periodic_expense = build(:periodic_expense, period: 'Something')

      expect(periodic_expense).not_to be_valid
    end

    context 'end_date is after start_date' do
      it 'is valid' do
        periodic_expense = build(:periodic_expense, start_date: DateTime.yesterday, end_date: DateTime.tomorrow)

        expect(periodic_expense).to be_valid
      end

      context 'last_created_at is between start_date and end_date' do
        it 'is valid' do
          periodic_expense = build(:periodic_expense, start_date: DateTime.now, end_date: DateTime.now + 5.months, last_created_at: DateTime.now + 1.months)

          expect(periodic_expense).to be_valid
        end
      end

      context 'last_created_at is after end_date' do
        it 'is invalid' do
          periodic_expense = build(:periodic_expense)
          periodic_expense.last_created_at = periodic_expense.end_date + 2.months

          expect(periodic_expense).not_to be_valid
        end
      end

      context 'last_created_at is before start_date' do
        it 'is invalid' do
          periodic_expense = build(:periodic_expense)
          periodic_expense.last_created_at = periodic_expense.start_date - 2.months

          expect(periodic_expense).not_to be_valid
        end
      end
    end

    context 'end_date is before start_date' do
      it 'is invalid' do
        periodic_expense = build(:periodic_expense, start_date: DateTime.tomorrow, end_date: DateTime.yesterday)

        expect(periodic_expense).not_to be_valid
      end
    end

    context 'there is no end_date' do
      it 'is valid' do
        periodic_expense = build(:periodic_expense, end_date: nil)

        expect(periodic_expense).to be_valid
      end
    end
  end
end
