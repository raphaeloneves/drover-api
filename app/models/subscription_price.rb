# frozen_string_literal: true

class SubscriptionPrice < ApplicationRecord
  belongs_to :car, class_name: 'Car'

  validates :price, :car, presence: true
  validates :price, numericality: { greater_than: 0 }
end
