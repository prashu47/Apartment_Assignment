class Calling
  require 'yaml'
  include Eventlog
  def initialize
    @input_data = YAML.load(File.read("../data/input.yml"))
    @var_data = @input_data.to_h
    @building_hash = {}
    @apartment_hash = {}
    @tenant_hash = {}
  end

  def call_building
    @var_data['buildings'].each do |building_no|
      building_no.each do |key, value|
        @building_hash[key] = Building.new(value["address"])
      end
    end
    puts @building_hash
  end
  def call_apartment
    @var_data['apartment'].each do |apartment_no|
      apartment_no.each do |key, value|
        @apartment_hash[key] = Apartment.new(value["apartment_number"],value["rent"],value["square_footage"],value["bedrooms"],value["bathrooms"])
      end
    end
    puts @apartment_hash
  end
  def call_tenants
    @var_data['tenants'].each do |tenant_no|
      tenant_no.each do |key, value|
        @tenant_hash[key] = Tenant.new(value["name"],value["age"],value["credit_score"])
      end
    end
    puts @tenant_hash
  end
end


calling = Calling.new
calling.call_building
calling.call_apartment
calling.call_tenants
