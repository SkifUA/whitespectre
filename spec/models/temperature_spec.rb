require 'rails_helper'

RSpec.describe Temperature, type: :model do
  subject { create(:temperature) }

  it 'must be valid' do
    expect(subject.valid?).to be_truthy
  end

  it 'must be invalid with empty magnitude' do
    subject.magnitude = nil
    expect(subject.valid?).to be_falsey
  end

  it 'must be invalid with empty offset' do
    subject.offset = nil
    expect(subject.valid?).to be_falsey
  end
end
