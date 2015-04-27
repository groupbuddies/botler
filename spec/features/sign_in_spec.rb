require 'rails_helper'

RSpec.feature 'sign in' do
  scenario 'with valid data' do
    user = create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'

    expect(current_path).to eq root_path
  end

  scenario 'with invalid data' do
    user = create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: "#{user.password}1"

    click_on 'Log in'

    expect(page).to have_text 'Invalid email or password.'
  end
end
