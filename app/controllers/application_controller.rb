# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ExceptionHandlerConcern

  def pagination_meta(collection)
    meta = {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      items_per_page: collection.limit_value,
      items_display: collection.count
    }

    meta[:previous_page] = collection.prev_page if collection.prev_page.present?
    meta[:next_page] = collection.next_page if collection.next_page.present?
    meta
  end
end
