class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :periodic_expense
  has_one :receipt

  validates :description, :user, :amount, :paid_on, :category, presence: true
  validates :paid_on, date: { before_or_equal_to: proc { Date.today } }
  validates_associated :receipt

  def format_amount
    '€' + amount.to_s
  end

  def format_vat
    vat.to_s + '%' unless vat.nil?
  end

  def format_amount_w_vat
    '€' + amount_w_vat.to_s unless vat.nil?
  end

  private

  def amount_w_vat
    amount + (amount * (vat / 100))
  end
end
