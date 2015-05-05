class PeriodicExpensesController < ApplicationController
  def index
    @periodic_expenses = PeriodicExpense.all
  end

  def new
    @periodic_expense = PeriodicExpense.new
  end

  def create
    @periodic_expense = PeriodicExpense.new(periodic_expense_params)
    if @periodic_expense.save
      flash[:notice] = 'Success'
      redirect_to periodic_expenses_path
    else
      render :new
    end
  end

  private

  def periodic_expense_params
    params.require(:periodic_expense).permit(:name, :amount, :period, :start_date, :end_date, :user_id)
  end
end
