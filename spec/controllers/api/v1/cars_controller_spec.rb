# frozen_string_literal: true

describe Api::V1::CarsController, type: :controller, json: true do
  let(:json) { JSON.parse(response.body) }

  describe '#index' do
    subject { get :index, params: request_params }
    let(:request_params) { {} }

    it_behaves_like 'paginatable_response'

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
          expect(json['cars']).to be_empty
        end
      end
      context 'and there are available cars' do
        before { create(:car, :available) }
        it 'should return an empty array' do
          subject
          expect(json['cars']).not_to be_nil
          expect(json['cars'].size).to eq 1
        end
      end
      context 'and there are available cars and cars with availability date greater than three months' do
        before do
          create(:car, :with_color, :with_available_at_after_three_months)
          create(:car, :with_color, :available)
        end
        it 'should return only the available cars' do
          subject
          expect(json['cars'].size).to eq 1
          car = json['cars'].first
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

      describe 'for limiting' do
        let(:request_params) { { limit: 1 } }
        it 'should return a limited number of objects' do
          subject
          expect(Car.count).to eq 2
          expect(json['cars'].size).to be 1
        end
      end

      describe 'for filtering' do
        describe 'by color' do
          let(:request_params) { { color: 'whiTe' } }
          it 'should filter the response by color (case insensitive)' do
            subject
            expect(Car.count).to eq 2
            expect(json['cars'].count).to eq 1
            expect(json['cars'].first['color']).to eq 'white'
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
            expect(json['cars'].count).to eq 1
            car = json['cars'].first
            maker = car['model']['maker_name']
            expect(maker).to eq 'BMW'
          end
        end
      end

      describe 'for sorting' do
        let(:request_params) { { sort: sorting_value, sort_dir: sorting_dir } }

        context 'without specify the sorting direction' do
          let(:sorting_value) { 'price' }
          let(:sorting_dir) { nil }
          it 'should sort in asc direction based on the sort target' do
            subject
            expect(json['cars'].size).to eq 2
            expect(json['cars'].first['subscription_price']['price'].to_f).to eq 100.0
            expect(json['cars'].last['subscription_price']['price'].to_f).to eq 200.0
          end
        end

        context 'with direction' do
          describe 'by year' do
            let(:sorting_value) { 'year' }

            context 'asc' do
              let(:sorting_dir) { 'asc' }
              it 'should sort year ASC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['year'].to_i).to eq 2018
                expect(json['cars'].last['year'].to_i).to eq 2021
              end
            end

            context 'desc' do
              let(:sorting_dir) { 'desc' }
              it 'should sort year DESC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['year'].to_i).to eq 2021
                expect(json['cars'].last['year'].to_i).to eq 2018
              end
            end
          end

          describe 'by availability' do
            let(:sorting_value) { 'availability' }

            context 'asc' do
              let(:sorting_dir) { 'asc' }
              it 'should sort available_at ASC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['available_at'].to_date).to eq 1.day.after.to_date
                expect(json['cars'].last['available_at'].to_date).to eq 3.days.after.to_date
              end
            end

            context 'desc' do
              let(:sorting_dir) { 'desc' }
              it 'should sort available_at DESC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['available_at'].to_date).to eq 3.days.after.to_date
                expect(json['cars'].last['available_at'].to_date).to eq 1.day.after.to_date
              end
            end
          end

          describe 'by price' do
            let(:sorting_value) { 'price' }

            context 'asc' do
              let(:sorting_dir) { 'asc' }
              it 'should sort subscription_price ASC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['subscription_price']['price'].to_f).to eq 100.0
                expect(json['cars'].last['subscription_price']['price'].to_f).to eq 200.0
              end
            end

            context 'desc' do
              let(:sorting_dir) { 'desc' }
              it 'should sort available_at DESC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['subscription_price']['price'].to_f).to eq 200.0
                expect(json['cars'].last['subscription_price']['price'].to_f).to eq 100.0
              end
            end
          end

          describe 'by color' do
            let(:sorting_value) { 'color' }

            context 'asc' do
              let(:sorting_dir) { 'asc' }
              it 'should sort color ASC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['color']).to eq 'purple'
                expect(json['cars'].last['color']).to eq 'white'
              end
            end

            context 'desc' do
              let(:sorting_dir) { 'desc' }
              it 'should sort color DESC' do
                subject
                expect(json['cars'].size).to eq 2
                expect(json['cars'].first['color']).to eq 'white'
                expect(json['cars'].last['color']).to eq 'purple'
              end
            end
          end
        end
      end
    end
  end

  describe '#update' do
    subject { put :update, params: updating_params }
    before :each do
      @car = create(:car, :available, id: 45, color: 'white', year: 2020)
    end
    let(:updating_params) do
      { id: 45, year: 2015, color: 'black' }
    end

    it 'should update the car' do
      subject
      should have_http_status(204)
      car = Car.find(45)
      expect(car['color']).to eq 'black'
      expect(car['year'].to_i).to eq 2015
    end

    context 'when the provided ID does not exist' do
      before { updating_params['id'] = 1000 }
      it 'should raise not found' do
        subject
        should have_http_status(404)
        expect(['error']).to be_present
      end
    end

    context 'and it has an invalid parameter' do
      before { updating_params[:year] = 1990 }

      it 'should raise unprocessed entity' do
        subject
        expect(['error']).to be_present
        should have_http_status(422)
      end
    end
  end

  describe '#create' do
    subject { post :create, params: creating_params }
    before :each do
      create(:model, id: 1)
    end

    let(:creating_params) do
      {
        car: {
          year: 2020, color: 'white',
          available_at: Time.zone.today, model_id: 1,
          subscription_price_attributes: { price: 99.99 }
        }
      }
    end

    it 'should create a new car' do
      subject
      should have_http_status(201)
      expect(json['car']['id']).to be_present
    end

    describe 'when the payload is invalid' do
      context 'and is missing a required parameter' do
        before { creating_params.delete(:car) }

        it 'should raise bad request' do
          subject
          expect(json['error']).to be_present
          should have_http_status(400)
        end
      end

      context 'and it has an invalid parameter' do
        before { creating_params[:car][:year] = 1990 }

        it 'should raise unprocessed entity' do
          subject
          expect(json['error']).to be_present
          should have_http_status(422)
        end
      end
    end
  end
end
