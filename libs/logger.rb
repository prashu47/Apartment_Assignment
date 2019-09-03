# frozen_string_literal: true

class Logger
  def self.add_entry(instance)
    time = Time.now
    log_time = time.strftime('%k:%M,%d/%m/%Y')
    if instance.is_a? Building
      output = log_time + "Building #{instance.address} created\n"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if instance.is_a? Apartment
      output = log_time + "Apartment #{instance.apartment_number} created\n"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if instance.is_a? Tenant
      output = log_time + "Tenant #{instance.name} created\n"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
  end
  def self.remove_entry(instance)
    time = Time.now
    log_time = time.strftime('%k:%M,%d/%m/%Y')
    if instance.is_a? Building
      output = log_time + "Building removed  #{instance.address}"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if instance.is_a? Apartment
      output = log_time + "Apartment removed #{instance.apartment_number}"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
    if instance.is_a? Tenant
      output = log_time + "Tenant removed #{instance.name}"
      file = File.open('../logs/events.log', 'a') { |event| event.write(output) }
    end
  end
end
