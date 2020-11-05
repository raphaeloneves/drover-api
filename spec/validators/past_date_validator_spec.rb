# frozen_string_literal: true

require 'support/validation_support'

describe PastDateValidator, type: :validator do
  let(:validator) { described_class.new }
  let(:validatable) do
    build_validatable(date: @date) do |klass|
      klass.send :validates, :date, past_date: true
    end
  end

  subject { validatable }

  context 'when it is a past date' do
    before do
      @date = 2.days.ago
    end
    it { is_expected.not_to be_valid }
  end

  context 'when it is a present or future date' do
    before do
      @date = Time.zone.today
    end
    it { is_expected.to be_valid }
  end
end
