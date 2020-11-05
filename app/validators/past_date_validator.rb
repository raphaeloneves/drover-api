# frozen_string_literal: true

class PastDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value&.past?

    record.errors.add(attribute, "#{attribute} cannot be in the past. Current value #{value}")
  end
end
