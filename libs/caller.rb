require "./building_class.rb"
require "./apartment_class.rb"
require "./modules.rb"
require "./tenant_class.rb"
# require "../events.log"
# require "./calling_class.rb"
Building.load_from_data
Tenant.load_from_data
Apartment.load_from_data
# Building.find("J K Landmark")
# Apartment.find(1)
# Tenant.find("prashu")
Building.export
Apartment.export
Tenant.export
# Logger.log_entry
a = Building.find("J K Landmark")
b = Apartment.find(1)
a.add_apartments(b)

Building.all
a.remove_apartments(1)
