class PeriodicExpensesController < ApplicationController
  authorize_resource

  def index
    @periodic_expenses = PeriodicExpense.all
  end

  def new
    setup
    @periodic_expense = PeriodicExpense.new
  end

  def create
    setup
    @periodic_expense = PeriodicExpense.new(periodic_expense_params)
    if @periodic_expense.save
      flash[:notice] = 'Success'
      redirect_to periodic_expenses_path
    else
      render :new
    end
  end

  private

  def setup
    @categories = Category.subcategories
    @periods = PeriodicExpense.periods
  end

  def periodic_expense_params
    params.require(:periodic_expense).permit(:description, :amount, :category_id,
      :period, :supplier, :vat, :cost_center, :payment_method,
      :start_date, :end_date).merge(user_id: current_user.id)
  end
end
