# frozen_string_literal: true

class Validatable < OpenStruct
  include ActiveModel::Validations
end

def build_validatable(data = {})
  obj = Validatable.new(data)
  if block_given?
    obj.class_eval do
      yield self
    end
  end
  obj
end
