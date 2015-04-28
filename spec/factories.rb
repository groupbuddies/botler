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
    value 100
    date { DateTime.now }
    user
  end

  factory :periodic_expense do
    name 'Github'
    amount 25
    period 'Monthly'
    start_date { DateTime.now }
    end_date { DateTime.now + 5.months }
    user
  end
end
