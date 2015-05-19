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
    save
  end

  def update(expense)
    setup_with(expense)
    unless update_expense && update_receipt
      merge_errors
      return false
    end
    true
  end

  private

  def setup
    @expense = Expense.new(expense_params)
    @receipt = Receipt.new(receipt_params)
  end

  def setup_with(expense)
    @expense = expense
    @receipt = expense.receipt
  end

  def expense_params
    @params.except(:picture)
  end

  def receipt_params
    { picture: @params[:picture], expense: @expense }
  end

  def update_expense
    @expense.update(expense_params)
  end

  def update_receipt
    return true unless receipt_params.key? :picture

    if @receipt.nil?
      @receipt = Receipt.create(receipt_params)
      @receipt.persisted?
    else
      @receipt.update(receipt_params)
    end
  end

  def merge_errors
    @expense.errors.messages.merge!(@receipt.errors.messages)
  end

  def save
    Expense.transaction do
      @expense.save!
      @receipt.save!
    end
    @expense.persisted?
  end
end
