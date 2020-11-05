# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :model, class_name: 'Model'
  has_one :subscription_price, class_name: 'SubscriptionPrice', dependent: :destroy

  validates :model, :year, :available_at, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 10.years.ago.year }
  validates :available_at, past_date: true

  scope :available, -> { where('available_at <= ?', 3.months.after.to_date) }
  scope :limiting_by, ->(limit) { limit(limit) }

end
