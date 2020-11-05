# frozen_string_literal: true

describe SubscriptionPrice, type: :model do
  describe 'validations' do
    describe 'cars' do
      it 'should be present' do
        should validate_presence_of(:car)
      end
    end
    describe 'price' do
      it 'should be present' do
        should validate_presence_of(:price)
      end
      it 'should be positive' do
        should validate_numericality_of(:price)
      end
    end
  end
end
