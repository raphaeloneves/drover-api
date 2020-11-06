# frozen_string_literal: true

module CarsConcern
  extend ActiveSupport::Concern

  def cars
    @cars ||= Car.available.
      sorting_by(sorting_params).
      filtering_by(filtering_params).
      includes({ model: :maker }, :subscription_price).
      paginate_by(paginate_param)
  end

  def car
    @car ||= Car.find(params[:id])
  end

  def filtering_params
    @filtering_params ||= params.permit(:color, :maker)
  end

  def sorting_params
    @sorting_params ||= params.permit(:sort, :sort_dir)
  end

  def updating_params
    @updating_params ||= params.permit(:id, :model_id, :year, :color, :available_at)
  end

  def creating_params
    params.require(:car).permit(
      :model_id, :year, :color, :available_at,
      subscription_price_attributes: %i[price]
    ).tap do |params|
      params.require(:subscription_price_attributes)
      params.require(:model_id)
      params.require(:year)
      params.require(:available_at)
    end
  end

  def paginate_param
    params.permit(:page, :limit)
  end
end
