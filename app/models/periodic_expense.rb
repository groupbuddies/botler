class PeriodicExpense < ActiveRecord::Base
  PERIODS = { 'weekly' => 1.week, 'monthly' => 1.month }

  belongs_to :user
  belongs_to :category
  has_many :expenses

  validates :description, :user, :amount, :period, :start_date, :category, presence: true
  validates :period, inclusion: { in: PERIODS.keys }
  validates :end_date, date: { after: :start_date }, if: :end_date
  validates :last_paid_on, date: { after: :start_date }, if: :last_paid_on
  validates :last_paid_on, date: { before: :end_date }, if: [:last_paid_on, :end_date]

  scope :current, -> { where('start_date <= :today AND (end_date IS NULL OR end_date > :today)', today: Date.today) }

  def self.periods
    PERIODS.keys
  end

  def due?
    !next_pay_on.future? && (end_date.nil? || end_date > Date.today)
  end

  def at_beginning_of_period(date)
    if period == 'weekly'
      date.at_beginning_of_week
    elsif period == 'monthly'
      date.at_beginning_of_month
    end
  end

  def create_expense
    Expense.create!(
      description: "#{description} (#{period.downcase})",
      user: user,
      periodic_expense: self,
      paid_on: Date.today,
      amount: amount,
      category: category
    )
  end

  private

  def next_pay_on
    last_pay = last_paid_on

    if last_pay.nil?
      last_pay = at_beginning_of_period(start_date)
    end

    last_pay + PERIODS[period]
  end
end
