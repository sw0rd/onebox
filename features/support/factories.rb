require 'factory_girl'


Factory.define :page do |f|
  f.name      Faker::Lorem.sentence
  f.category  '0'
  # f.seller    ''
  # f.query     ''
end