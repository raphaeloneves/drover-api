# frozen_string_literal: true


# check README file, section NOTES for an important info :)
module Filterable
  extend ActiveSupport::Concern

  def filtering_by(filtering_params)
    scope = all
    filtering_params&.each do |key, value|
      next if value.blank?

      method = "by_#{key}"
      return scope unless scope.respond_to?(method)

      scope = scope.public_send(method, value)
    end
    scope
  end
end
