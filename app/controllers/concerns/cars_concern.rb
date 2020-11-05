# frozen_string_literal: true

module CarsConcern
  extend ActiveSupport::Concern

  def cars
    @cars ||= Car.available.
      sorting_by(sorting_params).
      filtering_by(filtering_params).
      includes({ model: :maker }, :subscription_price).
      limiting_by(params[:limit])
  end

  def filtering_params
    @filtering_params ||= params.permit(:color, :maker)
  end

  def sorting_params
    @sorting_params ||= params.permit(:sort, :sort_dir)
  end

end
