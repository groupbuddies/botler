class PeriodicExpenseRunner
  attr_accessor :today

  def initialize
    @today = Date.today
  end

  def run
    PeriodicExpense.current.each do |periodic_expense|
      run_for_periodic_expense(periodic_expense)
    end
  end

  def run_for_periodic_expense(periodic_expense)
    return unless periodic_expense.due?

    periodic_expense.transaction do
      update_periodic_expense(periodic_expense)
      create_expense(periodic_expense)
    end
  end

  private

  def update_periodic_expense(periodic_expense)
    periodic_expense.update! last_paid_on: periodic_expense.at_beginning_of_period(today)
  end

  def create_expense(periodic_expense)
    Expense.create!(
      name: "#{periodic_expense.name} (#{periodic_expense.period.downcase})",
      user: periodic_expense.user,
      periodic_expense: periodic_expense,
      paid_on: today.to_datetime,
      amount: periodic_expense.amount
    )
  end
end
