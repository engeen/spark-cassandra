class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :inner_code
      t.string :adm_code
      t.string :tutu_code
      t.string :name_eng
      t.string :iata
      t.string :icao

      t.timestamps
    end
  end
end
