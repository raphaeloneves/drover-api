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

      def create
        render json: Car.create!(creating_params), status: :created
      end
    end
  end
end
