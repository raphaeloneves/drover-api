# frozen_string_literal: true

RSpec.shared_examples 'filterable' do
  let(:clazz) { described_class }
  it 'should act as filterable' do
    clazz.should respond_to? :filtering_by
  end
end
