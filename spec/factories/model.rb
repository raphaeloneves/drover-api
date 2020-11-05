# frozen_string_literal: true

FactoryBot.define do
  factory :model, class: 'Model' do
    name { Faker::FunnyName.name }
    maker { create(:maker) }
  end
end
