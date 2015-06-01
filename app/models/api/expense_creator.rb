class API::ExpenseCreator
  attr_accessor :expense

  def initialize(categories)
    @categories = categories
  end

  def create(expense_params)
    params = fix_params(expense_params)
    @expense = Expense.new(params)
    @expense.save
  end

  def errors
    @expense.errors.full_messages
  end

  private

  def fix_params(expense_params)
    subcategory_name = expense_params.delete(:subcategory)
    subcategory_id = @categories.find_by_name(subcategory_name)
    expense_params[:category] = subcategory_id
    expense_params[:paid_on] = Date.parse(expense_params[:paid_on])
    expense_params
  end
end
