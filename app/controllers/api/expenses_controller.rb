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
    creator = API::ExpenseCreator.new(Category)
    if creator.create(expense_params)
      respond_with creator.expense, status: 201
    else
      render json: { errors: creator.errors }, status: 422
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:paid_on, :subcategory, :description,
      :supplier, :amount, :vat, :cost_center, :payment_method, :user_id);
  end
end
