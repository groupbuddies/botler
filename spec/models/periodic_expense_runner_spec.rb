require 'rails_helper'

describe PeriodicExpenseRunner, type: :model do
  let(:runner) { PeriodicExpenseRunner.new }

  context '#run' do
    context 'monthly expense' do
      context 'last paid over a month ago' do
        it 'creates an expense' do
          last_pay = Date.new(2015, 2, 1)
          create(:periodic_expense, start_date: last_pay.prev_month, period: 'monthly', last_paid_at: last_pay)

          Timecop.freeze(last_pay.next_month)

          expect { runner.run }.to change { Expense.count }.by(1)
        end
      end

      context 'last paid less than a month ago' do
        it 'does not create an expense' do
          last_pay = Date.new(2015, 2, 1)
          create(:periodic_expense, start_date: last_pay.prev_month, period: 'monthly', last_paid_at: last_pay)

          Timecop.freeze(last_pay.next_week)

          expect { runner.run }.to change { Expense.count }.by(0)
        end
      end
    end

    context 'weekly expense' do
      context 'last paid over a week ago' do
        it 'creates an expense' do
          create(:periodic_expense, start_date: Date.new(2015, 1, 22), period: 'weekly', last_paid_at: Date.new(2015, 1, 26))

          Timecop.freeze(Date.new(2015, 2, 2))

          expect { runner.run }.to change { Expense.count }.by(1)
        end
      end

      context 'last paid less than a week ago' do
        it 'does not create an expense' do
          create(:periodic_expense, start_date: Date.new(2015, 1, 22), period: 'weekly', last_paid_at: Date.new(2015, 1, 26))

          Timecop.freeze(Date.new(2015, 1, 28))

          expect { runner.run }.to change { Expense.count }.by(0)
        end
      end
    end

    context 'no periodic expenses' do
      it 'does not create expenses' do
        runner.run

        expect(Expense.count).to eq 0
      end
    end
  end
end
