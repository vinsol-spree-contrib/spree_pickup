require 'spec_helper'

describe Spree::PickupLocation, type: :model do

  let(:pickup_location) { FactoryGirl.create(:pickup_location, :with_timings) }
  let(:location) { [1, 2] }
  let(:address) { FactoryGirl.create(:address) }
  let(:timings) { FactoryGirl.create_list(:timing, 2) }

  describe 'associations' do
    it { is_expected.to belong_to(:address) }
    it { is_expected.to have_many(:timings).dependent(:destroy) }
  end

  describe 'validations' do
    [:longitude, :latitude, :name].each do |attribute|
      context "when #{ attribute } is not present" do
        pickup_location = FactoryGirl.build(:pickup_location, "#{ attribute }"=> nil)
        pickup_location.valid?
        it 'does not save pickup_location' do
          expect(pickup_location.errors.present?).to be_truthy
          expect(pickup_location.errors[attribute]).to eq(["can't be blank"])
        end
      end
    end

    describe 'end_time_must_be_greater_than_start_time validation' do
      context 'when start_time time is less then end_time' do
        it 'saves object' do
          pickup_location = FactoryGirl.build(:pickup_location)
          expect(pickup_location.valid?).to be_truthy
        end
      end

      context 'when start_time is more then end_time' do
        it 'adds error to pickup_location object' do
          pickup_location = FactoryGirl.build(:pickup_location, start_time: Time.now, end_time: Time.now - 1.hour)
          expect(pickup_location.valid?).to be_falsey
          expect(pickup_location.errors.full_messages).to include("End time " + Spree.t(:greater_than_start_time))
        end
      end
    end
  end

  describe 'callbacks' do
    it { is_expected.to callback(:create_timings).before(:save).if(:open_day_ids_changed?) }
    it { is_expected.to callback(:update_geocode).before(:validation).if(:geocode_updation_required?) }
    it { is_expected.to callback(:set_open_day_ids).after(:initialize) }
  end

  describe 'attr_accessor' do
    it { is_expected.to respond_to(:open_day_ids) }
    it { is_expected.to respond_to(:open_day_ids_was) }
  end

  describe 'private methods' do
    describe '#set_open_day_ids' do
      it 'sets open day ids' do
        expect(pickup_location.send(:set_open_day_ids)).to eq(pickup_location.timings.map(&:day_id))
      end
    end

    describe '#create_timings' do
      before do
        pickup_location.send(:set_open_day_ids)
        pickup_location.send(:create_timings)
      end

      it 'creates timings for pickup_location from open ids' do
        expect(pickup_location.timings.map(&:day_id)).to eq(pickup_location.open_day_ids)
      end
    end

    describe '#update_geocode' do
      before do
        allow(pickup_location).to receive(:geocode).and_return(location)
        pickup_location.send(:update_geocode)
      end

      it 'updates the longitude and latitude of pickup_location' do
        expect(pickup_location.latitude).to eq(location.first)
        expect(pickup_location.longitude).to eq(location.last)
      end
    end

    describe 'nested attributes' do
      it { is_expected.to accept_nested_attributes_for(:address) }
    end

    describe '#my_address_changed?' do
      context 'when address is not changed' do
        it 'returns false' do
          expect(pickup_location.send(:my_address_changed?)).to be_falsey
        end
      end

      context 'when address is changed' do
        before { allow(pickup_location.address).to receive(:address2_changed?).and_return(true) }

        it 'returns true' do
          expect(pickup_location.send(:my_address_changed?)).to be_truthy
        end
      end
    end

    describe '#full_address' do
      it 'returns full address with all address attributes in an array' do
        address = pickup_location.address
        expect(pickup_location.send(:full_address)).to eq([address.address1, address.address2, address.zipcode, address.city, address.state.name, address.country.name].compact.join(', '))
      end
    end

    describe '#end_time_must_be_greater_than_start_time' do
      context 'when start_time time is less then end_time' do
        it 'returns nil' do
          expect(pickup_location.send(:end_time_must_be_greater_than_start_time)).to eq(nil)
        end
      end

      context 'when start_time is more then end_time' do
        before do
          pickup_location.update_attributes(start_time: pickup_location.end_time)
          pickup_location.update_attributes(end_time: pickup_location.end_time - 1.hour)
          pickup_location.send(:end_time_must_be_greater_than_start_time)
        end

        it 'adds error to pickup_location object' do
          expect(pickup_location.errors.full_messages).to include("End time " + Spree.t(:greater_than_start_time))
        end
      end
    end

    describe '#open_day_ids_changed?' do
      context 'when open_day_ids were changed' do
        before { pickup_location.open_day_ids = timings }

        it 'returns true' do
          expect(pickup_location.send(:open_day_ids_changed?)).to be_truthy
        end
      end

      context 'when open_day_ids were not changed' do
        it 'returns false' do
          expect(pickup_location.send(:open_day_ids_changed?)).to be_falsey
        end
      end
    end
  end
end
