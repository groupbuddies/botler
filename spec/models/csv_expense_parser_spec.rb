require 'rails_helper'

describe CsvExpenseParser, type: :model do
  let(:parser) { CsvExpenseParser.new }

  context '#parse' do
    it 'creates expenses' do
      expenses = parser.parse(File.join(
        Rails.root, 'spec', 'support', 'csvs', 'expenses.csv'))

      expect(expenses.count).to be 2
    end
  end
end
