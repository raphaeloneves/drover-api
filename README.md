# DROVER CHALLANGE - BACKEND

## Ruby version:
`2.6.5`

## Project Structure

The initial structure for this project has been created from [my rails blueprint](https://github.com/raphaeloneves/rails-scaffold)

## Extra dependencies added to the project
```
gem 'active_model_serializers', '0.10.0' -- scopes: global
gem 'rswag' -- scopes: global
gem 'kaminari' -- scopes: global


gem 'pry-byebug' -- scopes: development and test
gem 'rspec-its' -- scopes: development and test
gem 'rspec-rails' -- scopes: development and test
gem 'rubocop', '0.80.1', require: false -- scopes: development and test
gem 'rubocop-performance', require: false -- scopes: development and test
gem 'rubocop-rails', require: false -- scopes: development and test
gem 'factory_bot_rails' -- scopes: development and test
gem 'shoulda-matchers' -- scopes: development and test
gem 'faker' -- scopes: development and test

gem 'database_cleaner-active_record' -- scopes: test
gem 'simplecov' -- scopes: test
```

## Installing the application

### Docker

```
docker-compose up
```

### Locally

#### Installing dependencies

```
bundle install
```

#### Installing the resources

- Database creation

```
rails db:setup
```

- Database migration

```
rails db:migrate
```

- Database seed

```
rails db:seed
```

#### Initializing the application

```
rails s -p 3000 -b '0.0.0.0'
```

## Accessing the endpoints

### Host

`localhost:3000`

### Base URI

`/api/v1`

### Resources

```
swagger/v1/swagger.yaml
```

You can access a live documentation after running the project and accessing the [swagger-ui](http://localhost:3000/api-docs) page.

## Test suite

### Running the tests

```
bundle exec rspec
```

### Test scope

`models/*`, `validators/*`, `controllers/*`

### Test count

`44 examples`

### Current coverage

`100%`

After running the test suite, automatically a report containing the test coverage will be generated and can be accessed after running the project at [localhost](http://localhost:3000/coverage/index.html#_AllFiles)

## Extra configuration files

- Rspec: under `spec/*`
- Shoulda Matchers: under `spec/spec_helper.rb`
- DatabaseCleaner: under `spec/spec_helper.rb`
- FactoryBot: under `spec/spec_helper.rb`
- Validation Support: under `spec/support/validation_support.rb`
- Simplecov: under `spec/spec_helper.rb`

## Important note (credits)

- The `Filterable` module was inspired on Justin Weiss post [Search and Filter Rails Models Without Bloating Your Controller](https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/), giving my personal touch/modification.

## Feed for further discussion

- Minitest has been replaced by Rspec as test suite.

- Handled query n + 1 problems on makers, models and cars

```
Processing by Api::V1::CarsController#index as HTML
  SQL (1.8ms)  SELECT "cars"."id" AS t0_r0, "cars"."model_id" AS t0_r1, "cars"."year" AS t0_r2, "cars"."color" AS t0_r3, "cars"."available_at" AS t0_r4, "cars"."created_at" AS t0_r5, "cars"."updated_at" AS t0_r6, "models"."id" AS t1_r0, "models"."name" AS t1_r1, "models"."maker_id" AS t1_r2, "models"."created_at" AS t1_r3, "models"."updated_at" AS t1_r4, "makers"."id" AS t2_r0, "makers"."name" AS t2_r1, "makers"."created_at" AS t2_r2, "makers"."updated_at" AS t2_r3, "subscription_prices"."id" AS t3_r0, "subscription_prices"."price" AS t3_r1, "subscription_prices"."car_id" AS t3_r2, "subscription_prices"."created_at" AS t3_r3, "subscription_prices"."updated_at" AS t3_r4 FROM "cars" LEFT OUTER JOIN "models" ON "models"."id" = "cars"."model_id" LEFT OUTER JOIN "makers" ON "makers"."id" = "models"."maker_id" LEFT OUTER JOIN "subscription_prices" ON "subscription_prices"."car_id" = "cars"."id" WHERE (available_at <= '2021-02-04') ORDER BY subscription_prices.price asc
  ↳ app/controllers/api/v1/cars_controller.rb:9
Completed 200 OK in 106ms (Views: 87.8ms | ActiveRecord: 3.2ms)
```

- Centralized exception handler

- Defensive programming

- Shared examples (Rspec)

- Docker support

- Single responsibility priciple

- Subscription price modeling

- Global settings

- Specs configuration organization

- Validation


 