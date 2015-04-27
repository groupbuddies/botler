FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name 'John'
    password '12345678'
    email
  end

  factory :expense do
    name 'Jantar'
    value 100
    date { DateTime.now }
    user
  end
end
