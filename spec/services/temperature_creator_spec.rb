require 'rails_helper'

RSpec.describe TemperatureCreator, type: :service do
  let(:device) { create(:device, offset: 0.0) }
  let(:critical_magnitude) { ::Temperature::ALARM_MAGNITUDE }
  let(:normal_magnitude) { ::Temperature::ALARM_MAGNITUDE - 1.4 }

  describe '.call' do
    context 'should be success `false`' do
      it 'when empty attributes' do
        expect(TemperatureCreator.call({}).success?).to be_falsey
      end

      it 'when not exist device_id' do
        expect(
          TemperatureCreator.call({ device_id: device.id + 1, magnitude: normal_magnitude }).success?
        ).to be_falsey
      end

      it 'when not exist magnitude' do
        expect(TemperatureCreator.call({ device_id: device.id }).success?).to be_falsey
      end
    end

    context 'should be success `true`' do
      it 'when exist attributes' do
        expect(
          TemperatureCreator.call({ device_id: device.id, magnitude: normal_magnitude }).success?
        ).to be_truthy
      end
    end

    context 'should be created temperature' do
      it 'when exist attributes' do
        expect(
          TemperatureCreator.call({ device_id: device.id, magnitude: normal_magnitude }).temperature
        ).to be_a Temperature
      end
    end
  end

  describe '.alarm_status?' do
    context 'should not be send email if number of temperatures less than trend number' do
      it 'when exist attributes' do
        expect(
          TemperatureCreator.call({ device_id: device.id, magnitude: critical_magnitude }).send(:alarm_status?)
        ).to be_falsey
      end
    end

    context 'should not be send email' do
      before do
        (Temperature::LIMIT_FOR_TREND - 1).times do
          create(:temperature, device: device, magnitude: critical_magnitude, offset: 0.0)
        end
      end
      it 'when not have critical_magnitude trend' do
        expect(
          TemperatureCreator.call({ device_id: device.id, magnitude: normal_magnitude }).send(:alarm_status?)
        ).to be_falsey
      end
    end

    context 'should be send email' do
      before do
        (Temperature::LIMIT_FOR_TREND - 1).times do
          create(:temperature, device: device, magnitude: critical_magnitude, offset: 0.0)
        end
      end
      it 'when have critical_magnitude trend' do
        expect(
          TemperatureCreator.call({ device_id: device.id, magnitude: critical_magnitude }).send(:alarm_status?)
        ).to be_truthy
      end
    end
  end
end
