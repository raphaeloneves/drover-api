# frozen_string_literal: true

describe Filterable do
  let(:struct) { Struct.new(:where) { include Filterable } }
  let(:filterable) { struct.new('arg') }

  it 'should respond to filtering_by method' do
    expect(filterable.respond_to?(:filtering_by)).to be_truthy
  end
end
