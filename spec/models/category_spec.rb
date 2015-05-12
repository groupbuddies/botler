require 'rails_helper'

describe Category, type: :model do
  context '#valid?' do
    context 'with an used name' do
      it 'is invalid' do
        category = create(:category)
        other = build(:category, name: category.name)

        expect(other).to be_invalid
      end
    end
  end
end
