require 'rails_helper'

RSpec.feature 'List categories' do
  include API::JSONHelpers

  scenario 'all of them' do
    categories = create_list(:category, 2)

    visit api_categories_path

    expect(map_json_attribute(json_response, :name)).to eq categories.map(&:name)
  end

  scenario 'a category has a link to itself' do
    category = create(:category)

    visit api_categories_path

    expect(link_for_rel(json_response.first, 'self')).to eq api_category_url(category)
  end
end
