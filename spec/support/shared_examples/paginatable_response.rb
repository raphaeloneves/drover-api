# frozen_string_literal: true

RSpec.shared_examples 'paginatable_response' do
  let(:clazz) { described_class }
  it 'should contain pagination information' do
    subject
    meta = json['meta']
    expect(meta).to be_present
    expect(meta['current_page']).to be_present
    expect(meta['total_pages']).to be_present
    expect(meta['items_display']).to be_present
    expect(meta['items_per_page']).to be_present
  end
end
