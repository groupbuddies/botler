require 'rails_helper'

describe User, type: :model do
  context '#valid?' do
    it 'accepts a valid email' do
      user = build(:user)

      expect(user).to be_valid
    end

    it 'does not accept an invalid email' do
      user = build(:user, email: 'ben@a.a')

      expect(user).not_to be_valid
    end

    it 'does not accept an used email' do
      create(:user, email: 'person@example.com')
      user = build(:user, email: 'person@example.com')

      expect(user).not_to be_valid
    end
  end
end
