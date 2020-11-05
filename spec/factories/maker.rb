# frozen_string_literal: true

FactoryBot.define do
  factory :maker, class: 'Maker' do
    name { Faker::FunnyName.name }
  end
end
