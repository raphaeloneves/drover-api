# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  ALLOWED_DIRECTIONS = %w[asc desc].freeze
  DEFAULT_SORTING_METHOD = 'sorting_default'

  def sorting_by(sort_params)
    return public_send(DEFAULT_SORTING_METHOD) if sort_params[:sort].blank? &&
                                                  respond_to?(DEFAULT_SORTING_METHOD)

    method = "sorting_by_#{sort_params[:sort]}"
    public_send(method, sorting_direction(sort_params[:sort_dir])) if respond_to?(method)
  end

  def sorting_direction(param_direction)
    ALLOWED_DIRECTIONS.include?(param_direction&.downcase) ? param_direction : :asc
  end
end

