require 'rails_helper'

RSpec.feature 'Create a new expense' do
  def login
    login_as(create(:user))
  end

  scenario 'with valid data', js: true do
    skip
    category = create(:subcategory)
    expense_attributes = {
      'Description' => 'Jantar',
      'Amount' => 100,
      'Paid on' => Date.today
    }

    login
    visit new_expense_path

    fill_form(:expense, expense_attributes)
    select(category.parent.name, from: 'Category')
    select(category.name, from: 'Sub-category')
    attach_file('expense_picture',
      File.join(Rails.root, 'spec', 'support', 'images', 'receipt.jpg'))

    click_on 'Create Expense'

    expect(page).to have_text 'Jantar'
  end

  scenario 'with invalid data' do
    login
    visit new_expense_path

    fill_in 'Description', with: 'Jantar'

    click_on 'Create Expense'

    expect(page).to have_text "can't be blank"
  end

  scenario 'not authenticated' do
    visit new_expense_path

    expect(page).to have_text 'You are not authorized to access this page.'
  end
end
