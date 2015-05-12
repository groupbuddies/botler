require 'rails_helper'

RSpec.feature 'Show category' do
  scenario 'that exists' do
    category = create(:category, name: 'Meals')

    visit category_path(category)

    expect(page).to have_text 'Meals'
  end
end
