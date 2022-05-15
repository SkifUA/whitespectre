require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it 'must be valid' do
    expect(subject.valid?).to be_truthy
  end

  it 'must be invalid with empty fields' do
    expect(User.new.valid?).to be_falsey
  end

  it 'must be invalid with incorrect email' do
    subject.email = Faker::Name.name
    expect(subject.valid?).to be_falsey
  end
end
