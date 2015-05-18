module ExpenseRepresenter
  include Roar::JSON
  include Roar::Hypermedia

  property :description
  property :amount

  link :self do
    api_expense_url self
  end
end
