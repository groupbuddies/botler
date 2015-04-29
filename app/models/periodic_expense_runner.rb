class PeriodicExpenseRunner
  attr_accessor :today

  def initialize
    @today = Date.today
  end

  def run
    periodic_expenses.each do |periodic_expense|
      create_expense(periodic_expense)
    end
  end

  private

  def periodic_expenses
    PeriodicExpense.where('start_date <= :today AND (end_date IS NULL OR end_date > :today)', today: today)
  end

  def create_expense(periodic_expense)
    return unless periodic_expense.ready_to_pay?

    name = "#{periodic_expense.name} (#{periodic_expense.period.downcase})"
    periodic_expense.last_paid_at = today
    expense = Expense.new(name: name, user: periodic_expense.user, date: today.to_datetime, value: periodic_expense.amount)
    expense.save
  end
end
