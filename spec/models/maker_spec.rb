# frozen_string_literal: true

describe Maker, type: :model do
  describe 'validations' do
    describe 'name' do
      context 'presence' do
        it 'should be present' do
          should validate_presence_of(:name)
        end
      end
      context 'uniqueness' do
        before { create(:maker) }
        it 'should be unique' do
          should validate_uniqueness_of(:name)
        end
      end
    end
  end
end
