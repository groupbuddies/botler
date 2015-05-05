FactoryGirl.define do
  sequence :name do |n|
    "person#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name
    password '12345678'
    email
  end

  factory :expense do
    name 'Jantar'
    amount 100
    date { DateTime.now }
    association :user, factory: :user, strategy: :build
  end

  factory :periodic_expense do
    name 'Github'
    amount 25
    period 'monthly'
    start_date { Date.today }
    end_date { Date.today.next_year }
    association :user, factory: :user, strategy: :build
  end
end
