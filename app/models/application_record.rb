class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class Location < ActiveRecord::Base
    acts_as_mappable :default_units => :miles,
                     :default_formula => :sphere,
                     :distance_field_name => :distance,
                     :lat_column_name => :lat,
                     :lng_column_name => :lng
<<<<<<< HEAD
 end
 
=======
  end
>>>>>>> 2927f273af2148a3cfa98c8af3c7a575eae7d929
end
