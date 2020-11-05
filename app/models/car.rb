# frozen_string_literal: true

class Car < ApplicationRecord
  extend Filterable
  extend Sortable

  belongs_to :model, class_name: 'Model'
  has_one :subscription_price, class_name: 'SubscriptionPrice', dependent: :destroy

  validates :model, :year, :available_at, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 10.years.ago.year }
  validates :available_at, past_date: true

  scope :available, -> { where('available_at <= ?', 3.months.after.to_date) }
  scope :limiting_by, ->(limit) { limit(limit) }

  # filtering scopes
  scope :by_maker, lambda { |maker_name|
    joins(model: :maker).where('makers.name like ?', "%#{maker_name}%")
  }
  scope :by_color, ->(color) { where('color like ?', "%#{color}%") }

  # sorting
  scope :sorting_default, -> { sorting_by_price('asc') }
  scope :sorting_by_price, ->(direction) { order("subscription_prices.price #{direction}") }
  scope :sorting_by_availability, ->(direction) { order(available_at: direction) }
  scope :sorting_by_color, ->(direction) { order(color: direction) }
  scope :sorting_by_year, ->(direction) { order(year: direction) }

end
