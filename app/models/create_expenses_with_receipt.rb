class CreateExpensesWithReceipt
  attr_reader :expense

  def initialize(expense_params)
    @params = expense_params
  end

  def create
    setup
    unless @expense.valid?
      merge_errors
      return false
    end
    do_saves
  end

  private

  def setup
    @expense = Expense.new(@params.except(:picture))
    @receipt = Receipt.new(picture: @params[:picture], expense: @expense)
  end

  def merge_errors
    @expense.errors.messages.merge!(@receipt.errors.messages)
  end

  def do_saves
    Expense.transaction do
      @expense.save!
      @receipt.save!
    end
    @expense.persisted?
  end
end
