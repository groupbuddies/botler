class ExpensesController < ApplicationController
  authorize_resource

  def index
    @expenses = Expense.all
  end

  def new
    @categories = Category.subcategories
    @expense = Expense.new
  end

  def create
    expense_creator = CreateExpensesWithReceipt.new(expense_params)
    if expense_creator.create
      flash[:notice] = 'Success'
      redirect_to expenses_path
    else
      @categories = Category.subcategories
      @expense = expense_creator.expense
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :amount,
      :category_id, :paid_on, :supplier, :vat, :cost_center,
      :payment_method, :picture).merge(user_id: current_user.id)
  end
end
