require 'rails_helper'

RSpec.feature 'sign up' do
  scenario 'with valid data' do
    visit new_user_registration_path

    within 'form' do
      fill_in 'Name', with: 'person'
      fill_in 'Email', with: 'person@example.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'

      click_on 'Sign up'
    end

    expect(current_path).to eq root_path
    expect(page).to have_text 'Welcome! You have signed up successfully'
  end

  scenario 'with invalid data' do
    visit new_user_registration_path

    within 'form' do
      click_on 'Sign up'
    end

    expect(page).to have_text "Email can't be blank"
    expect(page).to have_text "Password can't be blank"
  end
end
