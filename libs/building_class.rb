class Building
  @@building_hash = {}
  require './modules.rb'
  require './logger'
  include LoadData
  include CreditRatingModule
  extend ProcessData
  attr_reader :address, :apartments ,:tenant_list
  def initialize(address)
    @address = address
    @apartments = Hash.new
    @tenant_list = tenant_list
    Logger.add_entry(self)

  end

  def add_apartments(parameter)
    key = parameter.apartment_number
    if @apartments[key] == nil
       @apartments[key] = parameter
    else
      puts "Already exists"
    end
  end

   def remove_apartments(apartment_number)
     key = apartment_number
      if @apartments[key] == nil || (@apartments[key].tenant_array.length !=0)
       #raise error message
       puts "There is no apartment or Empty apartment"
       else
        @apartments.delete(key)
      end
      Logger.remove_entry(self)
    end

    def square_footage
      foot = 0
      @apartments.each do |key,value|
        foot += value.square_footage
      end
      foot
    end

    def monthly_revenue
      tax = 0
      @apartments.each do |key,value|
        tax += value.rent
      end
      tax
    end

   def tenant_list
     tenant_list_array = Array.new
     @apartments.each do |key, value|
       tenant_list_array << (value.tenant_array)
     end
     tenant_list_array
   end

   def retrieve_apartments_credit_score
     puts "\n#{@address}"
     credit_score_hash = Hash.new
     @apartments.each do |key, value|
       credit_score_hash[value.avg_credit_score] = value.apartment_number
     end
     credit_score_hash = credit_score_hash.sort.reverse.to_h
     x = 1
     puts "No.\t+\tApNo.\t+\tCredit Score"
     credit_score_hash.each do |key, value|
       puts "#{x}.\t+\t#{value}\t+\t#{key}"
       x += 1
     end
   end

   def print_tenant_credit_rating
     tenant_hash = Hash.new do |hash, key|
       hash[key] = []
     end
     temp = tenant_list.flatten
     temp = temp.to_a.sort { |a, b| b.credit_score <=> a.credit_score }
     temp.each do |element|
        tenant_hash[find_credit_rating(element.credit_score)] << element.name
      end
      x = 1
      puts "No.\t+\tRating\t+\tTenant Name"
      tenant_hash.each do |key, value|
        puts "#{x}.\t+\t#{key}\t+\t#{value.join(", ")}"
        x += 1
      end
   end
   def self.load_from_data
     var_data = LoadData.loading_data
     var_data['buildings'].each do |building_no|
       building_no.each do |key, value|
         @@building_hash[key] = Building.new(value["address"])
       end
     end
   end

   def self.all
      puts @@building_hash
   end

   def self.find(parameter)
     @@building_hash.each do |key, value|
       if (value.address == parameter)
         puts "#{parameter} found"
         return @@building_hash[key]
       end
   end
   puts "Not Found"
 end
 def self.export
   apart = {"buildings" => [] }
   @@building_hash.each do |key, value|
     temp = {}
     temp["address"] = value.address
     apart["buildings"] << temp
   end
   converting(apart)
 end
end
