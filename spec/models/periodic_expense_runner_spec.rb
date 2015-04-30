require 'rails_helper'

describe PeriodicExpenseRunner, type: :model do
  let(:runner) { PeriodicExpenseRunner.new }

  context '#run_for_periodic_expense' do
    context 'monthly expense' do
      context 'last paid over a month ago' do
        it 'creates an expense' do
          last_paid_on = Date.new(2015, 2, 1)
          periodic_expense = create(:periodic_expense, start_date: last_paid_on.prev_month, period: 'monthly', last_paid_on: last_paid_on)

          Timecop.freeze(last_paid_on.next_month)

          expect { runner.run_for_periodic_expense(periodic_expense) }.to change { Expense.count }.by(1)
        end
      end

      context 'last paid less than a month ago' do
        it 'does not create an expense' do
          last_paid_on = Date.new(2015, 2, 1)
          periodic_expense = create(:periodic_expense, start_date: last_paid_on.prev_month, period: 'monthly', last_paid_on: last_paid_on)

          Timecop.freeze(last_paid_on.next_week)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end

      context 'with a start date in the future' do
        it 'does not create an expense' do
          today = Date.new(2015, 2, 1)
          periodic_expense = create(:periodic_expense, start_date: today.next_month, period: 'monthly')

          Timecop.freeze(today)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end

      context 'with an end date in the past' do
        it 'does not create an expense' do
          today = Date.new(2015, 2, 1)
          periodic_expense = create(:periodic_expense, start_date: today - 5.months, end_date: today - 2.months, period: 'monthly', last_paid_on: today - 3.months)

          Timecop.freeze(today)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end

      context 'in the beginning of the month after creation' do
        it 'creates an expense ' do
          created_on = Date.new(2015, 2, 15)
          periodic_expense = create(:periodic_expense, start_date: created_on, period: 'monthly')

          Timecop.freeze(created_on.next_month.at_beginning_of_month)

          expect { runner.run_for_periodic_expense(periodic_expense) }.to change { Expense.count }.by(1)
        end
      end

      context 'in the same month it was created' do
        it 'does not create an expense' do
          created_on = Date.new(2015, 2, 15)
          periodic_expense = create(:periodic_expense, start_date: created_on, period: 'monthly')

          Timecop.freeze(created_on.next_week)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end
    end

    context 'weekly expense' do
      context 'last paid over a week ago' do
        it 'creates an expense' do
          last_paid_on = Date.new(2015, 2, 1).beginning_of_week
          periodic_expense = create(:periodic_expense, start_date: last_paid_on.prev_month, period: 'weekly', last_paid_on: last_paid_on)

          Timecop.freeze(last_paid_on.next_week)

          expect { runner.run_for_periodic_expense(periodic_expense) }.to change { Expense.count }.by(1)
        end
      end

      context 'last paid less than a week ago' do
        it 'does not create an expense' do
          last_paid_on = Date.new(2015, 2, 1).beginning_of_week
          periodic_expense = create(:periodic_expense, start_date: last_paid_on.prev_month, period: 'weekly', last_paid_on: last_paid_on)

          Timecop.freeze(last_paid_on.next_day)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end

      context 'with a start date in the future' do
        it 'does not create an expense' do
          today = Date.new(2015, 2, 1)
          periodic_expense = create(:periodic_expense, start_date: today.next_month, period: 'weekly')

          Timecop.freeze(today)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end

      context 'with an end date in the past' do
        it 'does not create an expense' do
          today = Date.new(2015, 2, 1)
          periodic_expense = create(:periodic_expense, start_date: today - 5.months, end_date: today - 2.months, period: 'weekly', last_paid_on: today - 3.months)

          Timecop.freeze(today)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Expense.count }
        end
      end

      context 'in the beginning of the week after creation' do
        it 'creates an expense ' do
          created_on = Date.new(2015, 2, 15)
          periodic_expense = create(:periodic_expense, start_date: created_on, period: 'weekly')

          Timecop.freeze(created_on.next_week.at_beginning_of_week)

          expect { runner.run_for_periodic_expense(periodic_expense) }.to change { Expense.count }.by(1)
        end
      end

      context 'in the same week it was created' do
        it 'does not create an expense' do
          created_on = Date.new(2015, 2, 15).beginning_of_week.next_day
          periodic_expense = create(:periodic_expense, start_date: created_on, period: 'weekly')

          Timecop.freeze(created_on.next_day)

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
      it 'creates expenses' do
        today = Date.new(2015, 3, 1).next_week.beginning_of_week
        create(:periodic_expense, start_date: today - 2.months, period: 'monthly', last_paid_on: today.prev_month.beginning_of_month)
        create(:periodic_expense, start_date: today - 2.months, period: 'weekly', last_paid_on: today.prev_week)

        Timecop.freeze(today)

        expect { runner.run }.to change { Expense.count }.by(2)
      end

      it 'updates those periodic expenses' do
        today = Date.new(2015, 3, 1).next_week.beginning_of_week
        periodic_expense1 = create(:periodic_expense, start_date: today - 2.months, period: 'monthly', last_paid_on: today.prev_month.beginning_of_month)
        periodic_expense2 = create(:periodic_expense, start_date: today - 2.months, period: 'weekly', last_paid_on: today.prev_week)

        Timecop.freeze(today)
        runner.run

        expect(periodic_expense1.reload).not_to be_ready_to_pay
        expect(periodic_expense2.reload).not_to be_ready_to_pay
      end
    end
  end
end
