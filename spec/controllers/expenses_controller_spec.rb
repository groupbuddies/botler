require 'rails_helper'

describe ExpensesController, type: :controller do
  before(:each) do
    sign_in create(:user)
  end

  context 'POST /expenses' do
    context 'when all fields are valid' do
      it 'redirects to expenses#index' do
        user = create(:user)
        post :create, expense: { name: 'Jantar', value: 100, user_id: user.id }

        expect(response).to redirect_to(expenses_path)
      end
    end

    context 'when there are invalid fields' do
      it 'does not redirect to expenses#index' do
        user = create(:user)
        post :create, expense: { value: 100, user_id: user.id }

        expect(response).not_to redirect_to(expenses_path)
      end
    end
  end
end
