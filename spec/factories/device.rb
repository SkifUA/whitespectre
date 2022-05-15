FactoryBot.define do
  factory :device, class: 'Device' do
    association :user, factory: :user
    offset { Faker::Number.between(from: 10, to: 30) / 10.0  }
  end
end
