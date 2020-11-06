bmw = Maker.create!(name: 'BMW')
renault = Maker.create!(name: 'Renault')
toyota = Maker.create!(name: 'Toyota')

models = []
models << Model.create!(name: 'Yaris', maker: toyota)
models << Model.create!(name: 'RAV4', maker: toyota)

models << Model.create!(name: 'Series3', maker: bmw)
models << Model.create!(name: 'X1', maker: bmw)

models << Model.create!(name: 'Megane', maker: renault)
models << Model.create!(name: 'Clio', maker: renault)

100.times do
  car = Car.create!(
    model: models.sample, year: Faker::Number.between(from: 2010, to: Time.zone.today.year),
    color: Faker::Color.color_name,
    available_at: Faker::Date.between(from: Time.zone.today, to: 6.months.after)
  )
  SubscriptionPrice.create!(price: Faker::Number.decimal(l_digits: 2), car: car)
end