class PeriodicExpense < ActiveRecord::Base
  PERIODS = %w(Weekly Monthly)

  belongs_to :user

  validates :name, :user, :amount, :period, :start_date, presence: true
  validates :period, inclusion: { in: PERIODS }
  validate :end_date_is_after_start_date
  validate :last_created_at_is_between_start_and_end_dates

  private

  def end_date_is_after_start_date
    return if end_date.blank? || end_date > start_date

    errors.add(:end_date, 'cannot be before start date')
  end

  def last_created_at_is_between_start_and_end_dates
    return if last_created_at.blank? || between_start_and_end_dates?

    errors.add(:end_date, 'cannot be before start date')
  end

  def between_start_and_end_dates?
    last_created_at > start_date && (end_date.blank? || last_created_at < end_date)
  end
end
