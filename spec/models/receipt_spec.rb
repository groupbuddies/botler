require 'rails_helper'

describe Receipt, type: :model do
  context '#valid?' do
    context 'with all fields present' do
      it 'is valid' do
        receipt = create(:receipt)

        expect(receipt).to be_valid
      end
    end
  end
end
