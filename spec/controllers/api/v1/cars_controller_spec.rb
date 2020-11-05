# frozen_string_literal: true

describe Api::V1::CarsController, type: :controller, json: true do
  let(:json) { JSON.parse(response.body) }

  describe '#index' do
    subject { get :index, params: request_params }
    let(:request_params) { {} }

    it 'should return HTTP 200' do
      subject
      expect(response).to have_http_status(200)
    end

    describe 'when no query parameters are provided' do
      context 'and there are no cars with available date earlier than three months' do
        before do
          @car = create(:car, :with_available_at_after_three_months)
        end
        it 'should return an empty array' do
          subject
          expect(json).to be_empty
        end
      end
      context 'and there are available cars' do
        before { create(:car, :available) }
        it 'should return an empty array' do
          subject
          expect(json).not_to be_nil
          expect(json.size).to eq 1
        end
      end
      context 'and there are available cars and cars with availability date greater than three months' do
        before do
          create(:car, :with_color, :with_available_at_after_three_months)
          create(:car, :with_color, :available)
        end
        it 'should return only the available cars' do
          subject
          expect(json.size).to eq 1
          car = json.first
          date = Date.parse(car['available_at'])
          expect(date.past?).to be_falsey
        end
      end
    end

    describe 'when there are query parameters' do
      before :each do
        create(:car, id: 1, year: 2021, available_at: 1.day.after, color: 'white')
        create(:car, id: 2, year: 2018, available_at: 3.days.after, color: 'purple')
        create(:subscription_price, price: 200.0, car_id: 1)
        create(:subscription_price, price: 100.0, car_id: 2)
      end

      describe 'limiting' do
        let(:request_params) { { limit: 1 } }
        it 'should return a limited number of objects' do
          subject
          expect(Car.count).to eq 2
          expect(json.size).to be 1
        end
      end

      describe 'filtering' do
        describe 'by color' do
          let(:request_params) { { color: 'whiTe' } }
          it 'should filter the response by color (case insensitive)' do
            subject
            expect(Car.count).to eq 2
            expect(json.count).to eq 1
            expect(json.first['color']).to eq 'white'
          end
        end

        describe 'by maker name' do
          let(:maker) { create(:maker, name: 'BMW') }
          let(:model) { create(:model, maker: maker) }

          before { create(:car, :available, model: model, id: 45) }

          let(:request_params) { { maker: 'BmW' } }
          it 'should filter the response by maker name (case insensitive)' do
            subject
            expect(Car.count).to eq 3
            expect(json.count).to eq 1
            car = json.first
            maker = car['model']['maker']
            expect(maker['name']).to eq 'BMW'
          end
        end
      end
    end
  end
end
