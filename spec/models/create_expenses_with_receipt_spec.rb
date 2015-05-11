require 'rails_helper'

describe CreateExpensesWithReceipt, type: :model do
  let(:valid_params) do
    user = create(:user)
    attributes_for(:expense).merge(
      user_id: user.id,
      picture: Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'spec', 'support', 'images', 'receipt.jpg'))
    )
  end

  let(:params_without_picture) do
    user = create(:user)
    attributes_for(:expense).merge(user_id: user.id)
  end

  let(:params_without_user) do
    attributes_for(:expense).merge(
      picture: Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'spec', 'support', 'images', 'receipt.jpg')))
  end

  context '#create' do
    context 'with valid params' do
      it 'returns true' do
        creator = CreateExpensesWithReceipt.new(valid_params)

        expect(creator.create).to be true
      end

      it 'creates an expense' do
        creator = CreateExpensesWithReceipt.new(valid_params)

        expect { creator.create }.to change { Expense.count }.by 1
      end

      it 'creates a receipt' do
        creator = CreateExpensesWithReceipt.new(valid_params)

        expect { creator.create }.to change { Receipt.count }.by 1
      end
    end

    context 'without a picture' do
      it 'returns false' do
        creator = CreateExpensesWithReceipt.new(params_without_picture)

        expect(creator.create).to be false
      end

      it 'does not create expenses' do
        creator = CreateExpensesWithReceipt.new(params_without_picture)

        expect { creator.create }.not_to change { Expense.count }
      end

      it 'does not create receipts' do
        creator = CreateExpensesWithReceipt.new(params_without_picture)

        expect { creator.create }.not_to change { Receipt.count }
      end
    end

    context 'without a user' do
      it 'returns false' do
        creator = CreateExpensesWithReceipt.new(params_without_user)

        expect(creator.create).to be false
      end

      it 'does not create expenses' do
        creator = CreateExpensesWithReceipt.new(params_without_user)

        expect { creator.create }.not_to change { Expense.count }
      end

      it 'does not create receipts' do
        creator = CreateExpensesWithReceipt.new(params_without_user)

        expect { creator.create }.not_to change { Receipt.count }
      end
    end
  end
end
