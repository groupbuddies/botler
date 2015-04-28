require 'rails_helper'

RSpec.feature 'create a new expense' do
  def login
    login_as(create(:user))
  end

  scenario 'with valid data' do
    user = create(:user)

    login
    visit new_expense_path

    fill_in 'Name', with: 'Jantar'
    fill_in 'Value', with: 100
    select user.name, from: 'User'

    click_on 'Create Expense'

    expect(page).to have_text 'Jantar'
  end

  scenario 'with invalid data' do
    user = create(:user)

    login
    visit new_expense_path

    fill_in 'Name', with: 'Jantar'
    select user.name, from: 'User'

    click_on 'Create Expense'

    expect(page).to have_text 'Some fields were left blank'
  end

  scenario 'not authenticated' do
    visit new_expense_path

    expect(page).to have_text 'You are not authorized to access this page.'
  end
end
