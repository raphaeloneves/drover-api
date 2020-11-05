# frozen_string_literal: true

class Model < ApplicationRecord
  validates :name, :maker_id, presence: true
  belongs_to :maker, class_name: 'Maker'

  delegate :name, to: :maker, prefix: true

end
