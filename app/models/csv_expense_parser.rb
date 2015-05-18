require 'csv'

class CsvExpenseParser
  attr_reader :expenses

  def parse(filename)
    @expenses = Array.new
    CSV.foreach(filename) do |row|
      @expenses.push create_expense row
    end
  end

  private

  def create_expense(row)
    Expense.new(
      paid_on: Date.parse(row[1], 'DD/MM/YYYY'),
      category: Category.where(name: row[3]),
      description: row[4],
      supplier: row[5],
      amount: row[8].to_f,
      vat: row[7].to_f,
      cost_center: row[9],
      payment_method: row[10]
    )
  end
end
