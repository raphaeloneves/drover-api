# frozen_string_literal: true

FactoryBot.define do
  factory :car, class: 'Car' do
    year { 2020 }
    model { create(:model) }

    trait :with_color do
      color { Faker::Color.color_name }
    end

    trait :with_available_at_after_three_months do
      available_at { Time.zone.today + 4.months }
    end

    trait :available do
      available_at { Time.zone.today + 1.week }
    end
  end
end
