class PeriodicExpense < ActiveRecord::Base
  PERIODS = { 'weekly' => 1.week, 'monthly' => 1.month }

  belongs_to :user

  validates :name, :user, :amount, :period, :start_date, presence: true
  validates :period, inclusion: { in: PERIODS.keys }
  validate :end_date_is_after_start_date
  validate :last_paid_at_is_between_start_and_end_dates

  def period_as_time
    PERIODS[period]
  end

  def ready_to_pay?
    !next_pay.future?
  end

  private

  def end_date_is_after_start_date
    return if end_date.blank? || end_date > start_date

    errors.add(:end_date, 'cannot be before start date')
  end

  def last_paid_at_is_between_start_and_end_dates
    return if last_paid_at.blank? || between_start_and_end_dates?

    errors.add(:end_date, 'cannot be before start date')
  end

  def between_start_and_end_dates?
    last_paid_at > start_date && (end_date.blank? || last_paid_at < end_date)
  end

  def next_pay
    last_pay = last_paid_at

    if last_pay.nil?
      if period == 'weekly'
        last_pay = start_date.beginning_of_week
      elsif period == 'monthly'
        last_pay = start_date.beginning_of_month
      end
    end

    last_pay + period_as_time
  end
end
