require 'rails_helper'

RSpec.feature 'list all expenses' do
  def login
    login_as(create(:user))
  end

  scenario 'there are no expenses' do
    login
    visit root_path

    expect(page).to have_text 'There are no expenses.'
  end

  scenario 'there are expenses' do
    create(:expense, description: 'Almoço')
    create(:expense, description: 'Jantar')

    login
    visit root_path

    expect(page).to have_text 'Almoço'
    expect(page).to have_text 'Jantar'
  end

  scenario 'not authenticated' do
    visit root_path

    expect(page).to have_text 'You are not authorized to access this page.'
  end
end
