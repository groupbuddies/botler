require 'rails_helper'

RSpec.feature 'create a new periodic expense' do
  def login
    login_as(create(:user))
  end

  scenario 'with valid data' do
    periodic_expense_attributes = {
      description: 'Github',
      period: 'Monthly',
      amount: 25,
      category: create(:subcategory).name,
      start_date: Date.today,
      end_date: Date.today.next_year
    }

    login
    visit new_periodic_expense_path

    fill_form(:periodic_expense, periodic_expense_attributes)

    click_on 'Create Periodic expense'

    expect(page).to have_text 'Github'
  end

  scenario 'with invalid data' do
    login
    visit new_periodic_expense_path

    click_on 'Create Periodic expense'

    expect(page).to have_text "can't be blank"
  end

  scenario 'not authenticated' do
    visit new_expense_path

    expect(page).to have_text 'You are not authorized to access this page.'
  end
end
