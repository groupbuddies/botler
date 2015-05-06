class ExpensesController < ApplicationController
  authorize_resource

  def index
    @expenses = Expense.all
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      flash[:notice] = 'success'
      redirect_to expenses_path
    else
      flash.now[:error] = 'Some fields were left blank'
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :paid_on, :user_id)
  end
end
