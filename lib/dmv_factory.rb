require 'faraday'
require 'json'

class DmvFactory
    def create_co_facilities(co_dmv_office_locations)
    co_dmv_office_locations.map do |facility_data|
        facility = Facility.new(
        name: facility_data[:dmv_office],
        address: [
            facility_data[:address_li],
            facility_data[:address__1],
            facility_data[:city],
            facility_data[:state],
            facility_data[:zip]
            ].compact.join(', '),
        phone: facility_data[:phone],
        registered_vehicles: facility_data[:registered_vehicles],
        collected_fees: facility_data[:collected_fees])
    
        add_service(facility, facility_data[:services_p])
        facility 
        end
    end

    def create_ny_facilities(ny_dmv_office_locations)
    ny_dmv_office_locations.map do |facility_data|
        facility = Facility.new(
        name: [
            facility_data[:office_name],
            facility_data[:office_type],
            ].compact.join(', '),
        address: [
            facility_data[:street_address_line_1],
            facility_data[:city],
            facility_data[:state],
            facility_data[:zip_code],
            ].compact.join(', '),
        phone: facility_data[:public_phone_number],
        registered_vehicles: facility_data[:registered_vehicles],
        collected_fees: facility_data[:collected_fees])
    
        add_service(facility, facility_data[:services_p])
        facility 
        end
    end
       
    def create_mo_facilities(mo_dmv_office_locations)
        mo_dmv_office_locations.map do |facility_data|
            facility = Facility.new(
            name: facility_data[:name],
            address: [
                facility_data[:address1],
                facility_data[:city],
                facility_data[:state],
                facility_data[:zipcode],
                ].compact.join(', '),
            phone: facility_data[:phone],
            registered_vehicles: facility_data[:registered_vehicles],
            collected_fees: facility_data[:collected_fees])
        
            add_service(facility, facility_data[:services_p])
    
            facility 
            end
        end
           
    def add_service(facility, services_string)
        return unless services_string

        services_string.split(',').map(&:strip).each do |service|
            facility.add_service(service)
        end
    end
end
