require 'rails_helper'

describe PeriodicExpenseRunner, type: :model do
  let(:runner) { PeriodicExpenseRunner.new }

  context '#run_for_periodic_expense' do
    context 'with a periodic expense' do
      context 'that is ready to pay' do
        it 'creates a reminder' do
          periodic_expense = create(:periodic_expense, start_date: Date.today.last_month, last_paid_on: Date.today)
          allow(periodic_expense).to receive(:due?).and_return(true)

          expect { runner.run_for_periodic_expense(periodic_expense) }.to change { Reminder.count }.by(1)
        end
      end

      context 'that is not ready to pay' do
        it 'does not create a reminder' do
          periodic_expense = instance_double('PeriodicExpense', due?: false)

          expect { runner.run_for_periodic_expense(periodic_expense) }.not_to change { Reminder.count }
        end
      end
    end
  end

  context '#run' do
    it 'calls run_for_periodic_expense for each periodic expense' do
      periodic_expense = instance_double('PeriodicExpense')
      allow(PeriodicExpense).to receive(:current).and_return([periodic_expense, periodic_expense])

      expect(runner).to receive(:run_for_periodic_expense).with(periodic_expense)
      expect(runner).to receive(:run_for_periodic_expense).with(periodic_expense)

      runner.run
    end

    context 'with no periodic expenses' do
      it 'does not create reminders' do
        runner.run

        expect(Reminder.count).to eq 0
      end
    end
  end
end
