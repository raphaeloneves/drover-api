# frozen_string_literal: true

RSpec.shared_examples 'paginatable' do
  let(:clazz) { described_class }
  it 'should respond to sorting_by' do
    expect(clazz.respond_to? :paginate_by).to be_truthy
  end
end
