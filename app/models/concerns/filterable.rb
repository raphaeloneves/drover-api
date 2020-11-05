# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  def filtering_by(filtering_params)
    result = where(nil)
    filtering_params&.each do |key, value|
      method = "by_#{key}"
      return result unless result.respond_to?(method)

      result = result.public_send(method, value) if value.present?
    end
    result
  end
end
