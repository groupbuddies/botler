require 'rails_helper'

RSpec.feature 'create a new periodic expense' do
  scenario 'with valid data' do
    user = create(:user)

    visit new_periodic_expense_path

    fill_form(:periodic_expense,
      name: 'Github',
      period: 'Monthly',
      amount: 25,
      start_date: Date.today,
      end_date: Date.today.next_year,
      user: user.name
    )

    click_on 'Create Periodic expense'

    expect(page).to have_text 'Github'
  end

  scenario 'with invalid data' do
    visit new_periodic_expense_path

    click_on 'Create Periodic expense'

    expect(page).to have_text "can't be blank"
  end
end
