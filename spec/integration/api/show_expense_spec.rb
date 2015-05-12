require 'rails_helper'

RSpec.feature 'Show expense in the API' do
  include API::JSONHelpers

  scenario 'individual representation' do
    expense = create(:expense)

    visit api_expense_path expense

    expect(json_response['name']).to eq expense.name
    expect(json_response.key?('user_id')).not_to be
  end
end
