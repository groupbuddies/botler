require 'rails_helper'

RSpec.feature 'List all categories' do
  scenario 'there are no categories' do
    visit categories_path

    expect(page).to have_text 'There are no categories'
  end

  scenario 'there are categories' do
    create(:category, name: 'Meals')
    create(:category, name: 'Communication')

    visit categories_path

    expect(page).to have_text 'Meals'
    expect(page).to have_text 'Communication'
  end
end
