# frozen_string_literal: true

class ModelSerializer < ApplicationSerializer
  attributes :id, :name
  has_one :maker
end
