# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ExceptionHandlerConcern
end
