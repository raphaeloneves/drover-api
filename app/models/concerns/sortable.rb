# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  ALLOWED_DIRECTIONS = %w[asc desc].freeze
  DEFAULT_SORTING_METHOD = 'sorting_default'

  def sorting_by(sort_params)
    return all.public_send(DEFAULT_SORTING_METHOD) if sort_params[:sort].nil? && respond_to?(DEFAULT_SORTING_METHOD)

    method = "sorting_by_#{sort_params[:sort]}"
    return all unless respond_to? method

    all.public_send(method, sorting_direction(sort_params[:sort_dir]))
  end

  def sorting_direction(param_direction)
    ALLOWED_DIRECTIONS.include?(param_direction&.downcase) ? param_direction : :asc
  end
end
