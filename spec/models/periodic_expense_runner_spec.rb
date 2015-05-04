require 'rails_helper'

describe PeriodicExpenseRunner, type: :model do
  let(:runner) { PeriodicExpenseRunner.new }

  context '#run_for_periodic_expense' do
    context 'with a periodic expense' do
      context 'that is ready to pay' do
        it 'creates an expense' do
          periodic_expense = create(:periodic_expense,
                                    start_date: Date.today.last_month,
                                    period: 'monthly',
                                    last_paid_on: Date.today)
          allow(periodic_expense).to receive(:ready_to_pay?).and_return(true)

          expect { runner.run_for_periodic_expense(periodic_expense) }.to change { Expense.count }.by(1)
        end
      end

      context 'that is not ready to pay' do
        it 'does not create an expense' do
          periodic_expense = instance_double('PeriodicExpense', ready_to_pay?: false)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end
    end
  end

  context '#run' do
    context 'with no periodic expenses' do
      it 'does not create expenses' do
        runner.run

        expect(Expense.count).to eq 0
      end
    end

    context 'with periodic expenses that are ready to pay' do
      it 'creates expenses and updates periodic expenses' do
        today = Date.new(2015, 3, 1).next_week.beginning_of_week
        create(:periodic_expense, start_date: today - 2.months, period: 'monthly', last_paid_on: today.prev_month.beginning_of_month)
        create(:periodic_expense, start_date: today - 2.months, period: 'weekly', last_paid_on: today.prev_week)

        Timecop.freeze(today)

        expect { runner.run }.to change { Expense.count }.by(2)
        expect(periodic_expense1.reload).not_to be_ready_to_pay
        expect(periodic_expense2.reload).not_to be_ready_to_pay
      end
    end
  end
end
