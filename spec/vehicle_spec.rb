require 'spec_helper'

RSpec.describe Vehicle do
  before(:each) do
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )

    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
  end

  describe '#initialize' do
    it 'can initialize' do

      expect(@cruz).to be_an_instance_of(Vehicle)
      expect(@cruz.vin).to eq('123456789abcdefgh')
      expect(@cruz.year).to eq(2012)
      expect(@cruz.make).to eq('Chevrolet')
      expect(@cruz.model).to eq('Cruz')
      expect(@cruz.engine).to eq(:ice)
      # require 'pry';binding.pry
      expect(@cruz.registration_date).to be_nil
      expect(@cruz.plate_type).to eq(nil)
    end
  end

  describe '#antique?' do
    it 'can determine if a vehicle is an antique' do
      expect(@cruz.antique?).to eq(false)
      expect(@bolt.antique?).to eq(false)
      expect(@camaro.antique?).to eq(true)
    end
  end

  describe '#electric_vehicle?' do
    it 'can determine if a vehicle is an ev' do
      expect(@cruz.electric_vehicle?).to eq(false)
      expect(@bolt.electric_vehicle?).to eq(true)
      expect(@camaro.electric_vehicle?).to eq(false)
    end
  end

  describe '#registration' do

  before(:each) do
    @facility_1.register_vehicle(@cruz)
  end

    it 'identifies if a vehicle is registered' do
      # require 'pry'; binding.pry
      expect(@facility_1.registered_vehicles.include?(@cruz)).to eq(true)
    end

    it 'adds a registration date when registered' do
      date = "Date: 2023-01-12 ((2459957j,0s,0n),+0s,2299161j"
      
      @facility_1.add_registration_date(@cruz, date)

      expect(@cruz.registration_date).to eq("Date: 2023-01-12 ((2459957j,0s,0n),+0s,2299161j")
    end

    it 'adds a plate type when registered' do
      plate_type = "regular"
      @facility_1.add_plate_type(@cruz, plate_type)
# require 'pry'; binding.pry
      expect(@cruz.plate_type).to eq("regular")
    end

    xit 'collects registration fees' do
      fee = 100
      @facility_1.collect_fees(@cruz, fee)

      require 'pry'; binding.pry
      expect(@facility_1.collected_fees).to eq(100)
    end
  end
end
