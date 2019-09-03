class Tenant
  @@tenant_hash = {}
  require './logger'
  include CreditRatingModule
  extend ProcessData
  attr_reader :name, :credit_score

  def initialize(name,age,credit_score)
    @name = name
    @age = age
    @credit_score = credit_score
    credit_rating
    Logger.add_entry(self)
  end

  def credit_rating
    find_credit_rating(@credit_score)
  end
  def self.load_from_data
    var_data = LoadData.loading_data
    var_data['tenants'].each do |tenant_no|
    tenant_no.each do |key, value|
    @@tenant_hash[key] = Tenant.new(value["name"],value["age"],value["credit_score"])
      end
    end
  end
  def self.all
      @@tenant_hash
  end
  def self.find(parameter)
    @@tenant_hash.each do |key, value|
      if(value.name == parameter)
        puts "#{parameter} found"
        return @@tenant_hash[key]
      end
    end
      puts "Not found"
  end
  def self.export
    apart = {"tenants" => [] }
    @@tenant_hash.each do |key, value|
      temp = {}
      temp["credit_score"] = value.credit_score
      temp["name"] = value.name
      apart["tenants"] << temp
    end
    converting(apart)
  end
end
