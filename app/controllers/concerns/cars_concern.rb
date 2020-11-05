# frozen_string_literal: true

module CarsConcern
  extend ActiveSupport::Concern

  def cars
    @cars ||= Car.available.
      includes({ model: :maker }, :subscription_price).
      limiting_by(params[:limit])
  end
end
