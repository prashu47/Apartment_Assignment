class Apartment
  @@apartment_hash = {}
  require './modules'
  require './logger'
  include CreditRatingModule
  extend ProcessData
  attr_reader :square_footage, :apartment_number, :avg_credit_score, :rent, :tenant_array, :bedrooms, :bathrooms

  def initialize(apartment_number, rent, square_footage, bedrooms, bathrooms)
    @apartment_number = apartment_number
    @square_footage = square_footage
    @rent = rent
    @bedrooms = bedrooms
    @bathrooms = bathrooms
    @tenant_array =[]
    @avg_credit_score = avg_credit_score
    Logger.add_entry(self)
  end

  def avg_credit_score
    if @tenant_array.length > 0
      credit = 0
      @tenant_array.each do |x|
      credit += x.credit_score
      end
      avg_credit = credit/(@tenant_array.length)
      avg_credit
    else
      0
    end
  end

  def add_tenant(parameter)
    if parameter.credit_rating == "bad" or @tenant_array.length == @bedrooms
      puts "creadit rating is too low or there is no vacant apartments"
    else
      @tenant_array << parameter
    end
    @tenant_array
  end

  def remove_specific_tenant(parameter)
    if @tenant_array.include? parameter
      @tenant_array.delete(parameter)
    else
      puts " the tenant is not found"
    end
    Logger.remove_entry(self)
  end

  def remove_all_tenant
    @tenant_array.clear
    Logger.remove_entry(self)
  end
  def self.load_from_data
    var_data = LoadData.loading_data
    var_data['apartment'].each do |apartment_no|
      apartment_no.each do |key, value|
        @@apartment_hash[key] = Apartment.new(value["apartment_number"],value["rent"],value["square_footage"],value["bedrooms"],value["bathrooms"])
      end
    end
  end
  def self.all
      @@apartment_hash
  end
  def self.find(parameter)
    @@apartment_hash.each do |key, value|
      if(value.apartment_number == parameter)
        puts "#{parameter} found"
        return @@apartment_hash[key]
      end
    end
      puts "Not found"
  end
  def self.export
    apart = {"apartments" => [] }
    @@apartment_hash.each do |key, value|
      temp = {}
      temp["bedrooms"] = value.bedrooms
      temp["bathrooms"] = value.bathrooms
      temp["number"] = value.apartment_number
      apart["apartments"] << temp
    end
    converting(apart)
  end
end
