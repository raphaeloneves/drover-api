# frozen_string_literal: true

describe Sortable do
  let(:struct) { Struct.new(:where) { include Sortable } }
  let(:sortable) { struct.new('arg') }

  it 'should respond to filtering_by method' do
    expect(sortable.respond_to?(:sorting_by)).to be_truthy
  end
end
