class CreateExpensesWithReceipt
  def initialize(expense_params)
    @params = expense_params
  end

  def create_expense_and_receipt
    return false unless picture_exists?

    Expense.transaction do
      create_expense
      create_receipt
    end
    @expense
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
