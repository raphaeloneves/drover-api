# frozen_string_literal: true

module Api
  module V1
    class CarsController < ApplicationController
      include CarsConcern

      def index
        render json: cars
      end

    end
  end
end
