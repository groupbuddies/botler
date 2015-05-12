class API::ExpensesController < API::BaseController
  include Roar::Rails::ControllerAdditions
  represents :json, entity: ExpenseRepresenter

  def index
    respond_with Expense.all.to_a, represent_items_with: ExpenseRepresenter
  end

  def show
    expense = Expense.find(params[:id])
    respond_with expense
  end
end
