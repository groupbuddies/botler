require 'rails_helper'

describe UpdateExpenseAndReceipt, type: :model do
  let(:valid_params) do
    attributes_for(:expense).merge(
      user_id: create(:user).id,
      category_id: create(:category).id,
      picture: Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'spec', 'support', 'images', 'receipt.jpg'))
    )
  end

  context '#update' do
    context 'with valid params' do
      it 'returns true' do
        expense = create(:expense)
        updater = UpdateExpenseAndReceipt.new(expense)

        expect(updater.update(valid_params)).to be true
      end

      it 'updates the expense' do
        expense = create(:expense, description: 'Old')
        updater = UpdateExpenseAndReceipt.new(expense)

        updater.update(valid_params.merge(description: 'New'))

        expect(expense.reload.description).to eq 'New'
      end
    end

    context 'with invalid params' do
      it 'returns false' do
        expense = create(:expense)
        updater = UpdateExpenseAndReceipt.new(expense)

        expect(updater.update(valid_params.merge(description: nil))).to be false
      end

      it 'does not update the expense' do
        expense = create(:expense, description: 'Old')
        updater = UpdateExpenseAndReceipt.new(expense)

        updater.update(valid_params.merge(description: nil))

        expect(expense.reload.description).to eq 'Old'
      end
    end
  end
end
