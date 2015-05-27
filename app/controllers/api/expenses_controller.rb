class API::ExpensesController < API::BaseController
  include Roar::Rails::ControllerAdditions
  represents :json, entity: ExpenseRepresenter

  def index
    expenses = Expense.all
    respond_with expenses.to_a, represent_items_with: ExpenseRepresenter
  end

  def show
    expense = Expense.find(params[:id])
    respond_with expense
  end

  def create
    expense = Expense.new(expense_params)
    if expense.save
      respond_with expense, status: 201
    else
      render json: { errors: expense.errors.full_messages }, status: 422
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:paid_on, :subcategory, :description,
      :supplier, :amount, :vat, :cost_center, :payment_method);
  end
end
