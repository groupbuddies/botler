require 'rails_helper'

RSpec.feature 'permissions' do
  scenario 'not authenticated' do
    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'authenticated' do
    user = create(:user)
    login_as(user)

    visit root_path

    expect(current_path).to eq root_path
  end
end
