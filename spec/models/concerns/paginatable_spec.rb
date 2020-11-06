# frozen_string_literal: true

describe Paginatable do
  let(:struct) { Struct.new(:where) { include Paginatable } }
  let(:paginatable) { struct.new('arg') }

  it 'should respond to paginate_by method' do
    expect(paginatable.respond_to?(:paginate_by)).to be_truthy
  end

  it 'should respond to items_per_page method' do
    expect(paginatable.respond_to?(:items_per_page)).to be_truthy
  end

  it 'defines items_per_page default value' do
    expect(paginatable.items_per_page).to eq 20
  end
end
