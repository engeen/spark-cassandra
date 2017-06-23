class CityNode
  include Cequel::Record




  key :id, :bigint #, auto: true
  column :name, :text


end
