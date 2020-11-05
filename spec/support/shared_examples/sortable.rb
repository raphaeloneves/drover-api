# frozen_string_literal: true

RSpec.shared_examples 'sortable' do
  let(:clazz) { described_class }
  it 'should act as sortable' do
    clazz.should respond_to? :sorting_by
  end
end
