require 'rails_helper'

describe PeriodicExpensesController, type: :controller do
  context 'POST /periodic_expenses' do
    context 'with valid fields' do
      it 'creates a new periodic expenses' do
        user = create(:user)
        periodic_expense_hash = { periodic_expense: {
          name: 'Github',
          amount: 100,
          period: 'monthly',
          start_date: Date.today,
          user_id: user.id
        } }

        expect { post :create, periodic_expense_hash }.to change { PeriodicExpense.count }.by 1
      end
    end

    context 'with some invalid fields' do
      it 'does not create a new periodic expenses' do
        periodic_expense_hash = { periodic_expense: { name: 'Github' } }

        expect { post :create, periodic_expense_hash }.not_to change { PeriodicExpense.count }
      end
    end
  end
end
