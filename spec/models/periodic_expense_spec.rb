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

    context 'end_date' do
      context 'after start_date' do
        it 'is valid' do
          periodic_expense = build(:periodic_expense, start_date: DateTime.yesterday, end_date: DateTime.tomorrow)

          expect(periodic_expense).to be_valid
        end
      end

      context 'before start_date' do
        it 'is invalid' do
          periodic_expense = build(:periodic_expense, start_date: DateTime.tomorrow, end_date: DateTime.yesterday)

          expect(periodic_expense).not_to be_valid
        end
      end

      context 'absent' do
        it 'is valid' do
          periodic_expense = build(:periodic_expense, end_date: nil)

          expect(periodic_expense).to be_valid
        end
      end
    end

    context 'last_paid_at' do
      context 'between start_date and end_date' do
        it 'is valid' do
          start_date = DateTime.now
          periodic_expense = build(:periodic_expense, start_date: start_date, end_date: start_date + 5.months, last_paid_at: start_date + 1.months)

          expect(periodic_expense).to be_valid
        end
      end

      context 'after end_date' do
        it 'is invalid' do
          end_date = DateTime.now + 5.months
          periodic_expense = build(:periodic_expense, end_date: end_date, last_paid_at: end_date + 1.months)

          expect(periodic_expense).not_to be_valid
        end
      end

      context 'before start_date' do
        it 'is invalid' do
          start_date = DateTime.now
          periodic_expense = build(:periodic_expense, start_date: start_date, last_paid_at: start_date - 2.months)

          expect(periodic_expense).not_to be_valid
        end
      end
    end
  end

  context '#ready_to_pay?' do
    context 'monthly expense' do
      context 'last paid over a month ago' do
        it 'returns true' do
          last_pay = Date.new(2015, 2, 1)
          periodic_expense = build(:periodic_expense, start_date: last_pay.prev_month, period: 'monthly', last_paid_at: last_pay)
          today = last_pay.next_month

          Timecop.freeze(today)

          expect(periodic_expense.ready_to_pay?).to be true
        end
      end

      context 'last paid less than a month ago' do
        it 'returns false' do
          last_pay = Date.new(2015, 2, 1)
          periodic_expense = build(:periodic_expense, start_date: last_pay.prev_month, period: 'monthly', last_paid_at: last_pay)
          today = last_pay.next_week

          Timecop.freeze(today)

          expect(periodic_expense.ready_to_pay?).to be false
        end
      end
    end

    context 'weekly expense' do
      context 'last paid over a week ago' do
        it 'returns true' do
          last_pay = Date.new(2015, 2, 1).beginning_of_week
          periodic_expense = build(:periodic_expense, start_date: last_pay.prev_month, period: 'weekly', last_paid_at: last_pay)
          today = last_pay.next_week

          Timecop.freeze(today)

          expect(periodic_expense.ready_to_pay?).to be true
        end
      end

      context 'last paid less than a week ago' do
        it 'returns false' do
          last_pay = Date.new(2015, 2, 1).beginning_of_week
          periodic_expense = build(:periodic_expense, start_date: last_pay.prev_month, period: 'weekly', last_paid_at: last_pay)
          today = last_pay.next_day

          Timecop.freeze(today)

          expect(periodic_expense.ready_to_pay?).to be false
        end
      end
    end
  end
end