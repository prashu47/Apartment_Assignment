module CreditRatingModule
  def find_credit_rating(credit_score)
    case credit_score
    when (725..760)
      "great"
    when(660..725)
       "good"
     when (560..660)
       "mediocre"
     else
       if credit_score >= 760
         "excellent"
       else
         "bad"
       end
     end
   end
end

module LoadData
  def self.loading_data
  require "yaml"
  input_data = YAML.load(File.read("../data/input.yml"))
  var_data = input_data.to_h
  end
end

module ProcessData
 require 'yaml'
 def load_yaml
   inputdata = YAML.load(File.read("../data/input.yml"))
   full_data = inputdata.to_h
 end
 def converting(input)
   File.open("../data/output.yml", "a") { |file| file.write(input.to_yaml) }
 end
end
