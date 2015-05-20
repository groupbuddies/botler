require 'rails_helper'

RSpec.feature 'Update expense' do
  def login
    login_as(create(:user))
  end

  let(:expense) { create(:expense) }

  scenario 'with valid data' do
    expense_attributes = {
      description: 'Jantar',
      amount: 100,
      category: create(:subcategory).name,
      paid_on: Date.today
    }

    login
    visit edit_expense_path(expense)

    fill_form(:expense, expense_attributes)
    attach_file('expense_picture',
      File.join(Rails.root, 'spec', 'support', 'images', 'receipt.jpg'))

    click_on 'Update Expense'

    expect(page).to have_text 'Jantar'
  end

  scenario 'with invalid data' do
    login
    visit edit_expense_path(expense)

    fill_in 'Description', with: ''

    click_on 'Update Expense'

    expect(page).to have_text "can't be blank"
  end

  scenario 'not authenticated' do
    visit edit_expense_path(expense)

    expect(page).to have_text 'You are not authorized to access this page.'
  end
end
