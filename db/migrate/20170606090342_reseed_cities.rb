require 'csv'
require Rails.root.join('db','support.rb')
class ReseedCities < ActiveRecord::Migration[5.1]
  def change
    City.delete_all
    load_file(City)
  end
end
