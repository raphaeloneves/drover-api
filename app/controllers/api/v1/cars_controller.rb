# frozen_string_literal: true

module Api
  module V1
    class CarsController < ApplicationController
      include CarsConcern

      def index
        render json: cars
      end

      def update
        render json: car.update!(updating_params), status: :no_content
      end
    end
  end
end
