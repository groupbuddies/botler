require 'rails_helper'

RSpec.feature 'List expenses in the API' do
  include API::JSONHelpers

  scenario 'all of them' do
    expenses = create_list(:expense, 2)

    visit api_expenses_path

    expect(map_json_attribute(json_response, :description)).to eq expenses.map(&:description)
    expect(map_json_attribute(json_response, :user_id)).to be_empty
  end

  scenario 'an expense has a link to itself' do
    expense = create(:expense)
    visit api_expenses_path

    expect(link_for_rel(json_response.first, 'self')).to eq api_expense_url(expense)
  end
end
