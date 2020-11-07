# frozen_string_literal: true


# check README file, section NOTES for an important info :)
module Filterable
  extend ActiveSupport::Concern

  def filtering_by(filtering_params)
    result = where(nil)
    filtering_params&.each do |key, value|
      next if value.blank?

      method = "by_#{key}"
      return result unless result.respond_to?(method)

      result = result.public_send(method, value)
    end
    result
  end
end
