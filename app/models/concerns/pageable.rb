# frozen_string_literal: true

module Pageable
  extend ActiveSupport::Concern

  PAGE_LIMIT = 20

  def items_per_page
    PAGE_LIMIT
  end

  def paginate_by(params)
    page_number = params[:page] || 1
    limit_number = params[:limit] || items_per_page
    page(page_number).per(limit_number)
  end
end
