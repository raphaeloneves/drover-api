# frozen_string_literal: true
module Sortable
  extend ActiveSupport::Concern

  ALLOWED_DIRECTIONS = %w[asc desc].freeze

  def sorting_by(sort_params)
    result = where(nil)
    return result.public_send('sorting_default') if sort_params[:sort].blank?

    method = "sorting_by_#{sort_params[:sort]}"
    return result unless result.respond_to?(method)

    result.public_send(method, sorting_direction(sort_params[:sort_dir]))
  end

  def sorting_direction(param_direction)
    ALLOWED_DIRECTIONS.include?(param_direction&.downcase) ? param_direction : :asc
  end
end

