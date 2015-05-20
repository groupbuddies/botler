class UpdateExpenseAndReceipt
  attr_reader :expense

  def initialize(expense)
    @expense = expense
    @receipt = expense.receipt
  end

  def update(expense_params)
    @params = expense_params
    update_expense_and_receipt
    unless @expense.valid?
      merge_errors
      return false
    end
    true
  end

  private

  def update_expense_and_receipt
    Expense.transaction do
      update_expense
      update_or_create_receipt
    end
  end

  def update_expense
    @expense.update(expense_params)
  end

  def expense_params
    @params.except(:picture)
  end

  def update_or_create_receipt
    return true unless receipt_params.key? :picture

    if @receipt.nil?
      @receipt = Receipt.create(receipt_params)
      @receipt.persisted?
    else
      @receipt.update(receipt_params)
    end
  end

  def receipt_params
    { picture: @params[:picture], expense: @expense }
  end

  def merge_errors
    return if @receipt.nil?
    @expense.errors.messages.merge!(@receipt.errors.messages)
  end
end
