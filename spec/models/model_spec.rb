# frozen_string_literal: true

describe Model, type: :model do
  describe 'validations' do
    describe 'name' do
      it 'should be present' do
        should validate_presence_of(:name)
      end
    end
    describe 'maker_id' do
      it 'should be present' do
        should validate_presence_of(:maker_id)
      end
    end
  end
end
