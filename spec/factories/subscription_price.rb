FactoryBot.define do
  factory :subscription_price, class: 'SubscriptionPrice' do

    price { 10.0 }

    trait :active do
      active { true }
    end

    trait :with_car do
      car { create(:car, :available) }
    end
  end
end
