class CreateExpensesWithReceipt
  attr_reader :expense

  def initialize(expense_params)
    @params = expense_params
  end

  def create
    return false unless picture_exists?

    Expense.transaction do
      create_expense
      create_receipt
    end
    @expense.persisted?
  end

  private

  def picture_exists?
    !@params[:picture].nil?
  end

  def create_expense
    @expense = Expense.create!(@params.except(:picture))
  end

  def create_receipt
    Receipt.create!(picture: @params[:picture], expense: @expense)
  end
end
