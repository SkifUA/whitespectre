FactoryBot.define do
  factory :temperature, class: 'Temperature' do
    association :device, factory: :device
    offset { 0.0 }
    magnitude { Faker::Number.between(from: 350, to: 400) / 10.0 }
  end
end
