FactoryGirl.define do
  sequence :name do |n|
    "name#{n}"
  end

  sequence :email do |n|
    "name#{n}@example.com"
  end

  factory :user do
    name
    password '12345678'
    email
  end

  factory :category do
    name
  end

  factory :expense do
    name 'Jantar'
    amount 100
    paid_on { DateTime.now }
    association :user, factory: :user, strategy: :build
    association :category, factory: :category, strategy: :create
  end

  factory :periodic_expense do
    name 'Github'
    amount 25
    period 'monthly'
    start_date { Date.today }
    end_date { Date.today.next_year }
    association :user, factory: :user, strategy: :build
    association :category, factory: :category, strategy: :create
  end

  factory :receipt do
    picture do
      Rack::Test::UploadedFile.new(File.join(
        Rails.root, 'spec', 'support', 'images', 'receipt.jpg'))
    end
    association :expense, factory: :expense, strategy: :create
  end
end
