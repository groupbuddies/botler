require 'rails_helper'

RSpec.feature 'list all expenses' do
  scenario 'there are no expenses' do
    visit root_path

    expect(page).to have_text 'There are no expenses.'
  end

  scenario 'there are expenses' do
    create(:expense, name: 'Almoço')
    create(:expense, name: 'Jantar')

    visit root_path

    expect(page).to have_text 'Almoço'
    expect(page).to have_text 'Jantar'
  end
end
