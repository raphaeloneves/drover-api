# frozen_string_literal: true

class CarSerializer < ApplicationSerializer
  attributes :id, :year, :color, :available_at
  has_one :model
  has_one :subscription_price
end
