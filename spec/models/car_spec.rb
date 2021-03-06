# frozen_string_literal: true

describe Car, type: :model do

  it_behaves_like 'filterable'
  it_behaves_like 'sortable'
  it_behaves_like 'paginatable'

  describe 'validations' do
    describe 'model' do
      it 'should be present' do
        should validate_presence_of(:model)
      end
    end
    describe 'year' do
      it 'should be present' do
        should validate_presence_of(:year)
      end
      it 'should be greater than 10 years ago' do
        should validate_numericality_of(:year)
      end
    end
    describe 'available_at' do
      it 'should be present' do
        should validate_presence_of(:available_at)
      end
    end
  end
end
