class CreateExpensesWithReceipt
  attr_reader :expense

  def initialize(expense_params)
    @params = expense_params
  end

  def create
    setup
    unless @expense.valid? && @receipt.valid?
      @expense.errors.messages.merge!(@receipt.errors.messages)
      return false
    end
    do_saves
    @expense.persisted?
  end

  private

  def setup
    @expense = Expense.new(@params.except(:picture))
    @receipt = Receipt.new(picture: @params[:picture], expense: @expense)
  end

  def do_saves
    Expense.transaction do
      @expense.save!
      @receipt.save!
    end
  end
end
