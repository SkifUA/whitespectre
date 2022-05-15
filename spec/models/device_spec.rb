require 'rails_helper'

RSpec.describe Device, type: :model do
  subject { create(:device) }

  it 'must be valid' do
    expect(subject.valid?).to be_truthy
  end

  it 'must be invalid with empty offset' do
    subject.offset = nil
    expect(subject.valid?).to be_falsey
  end
end
