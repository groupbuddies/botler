class ExpensesController < ApplicationController
  authorize_resource

  def index
    @expenses = Expense.all
  end

  def new
    setup
    @expense = Expense.new
  end

  def create
    setup
    expense_creator = CreateExpensesWithReceipt.new(expense_params)
    if expense_creator.create
      flash[:notice] = 'Success'
      redirect_to expenses_path
    else
      @expense = expense_creator.expense
      render :new
    end
  end

  private

  def setup
    @categories = Category.subcategories
    @users = User.all
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :category_id, :paid_on, :user_id, :picture)
  end
end
