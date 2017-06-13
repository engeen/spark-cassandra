class ScheduleNode
	include Cequel::Record


	#CRUISE_CLASSES = %w(eco biz)
	#TRANSPORT_TYPES = %w(rail avia)

  CRUISE_CLASSES = OpenStruct.new(
    econom:       'eco',
    business:     'biz',
    first:        '1st',
    common:       'common',
    sitting:      'sitting',
    plazcard:     'plazcard',
    compartment:  'compartment',
    lux:          'lux',
    soft:         'soft'
  )

  TRANSPORT_TYPES = OpenStruct.new(
    avia: 'avia',
    rail: 'rail',
    auto: 'auto'
  )

  #column :id, :timeuuid, auto: true 

  key    :carrier, :text
  key    :cruise_num, :text      #номер рейса/номер поезда/маршрута
	key    :departure, :timestamp  #дата отправления

	column :transport_type, :text, :index => true #enumeration of transport type
	column :cruise_duration, :int #duration in minutes
	column :cruise_class, :text   #enumeration of class
	column :cruise_filter, :text, :index => true  #дубликат номера рейса для выборок

	column :from_location, :text, :index => true  #пункт отправления
	column :to_location, :text, :index => true    #пункт назначения

	column :departure_time, :timestamp, :index => true #departure date-time
	column :arrival_time, :timestamp, :index => true   #arrival date-time
	column :arrival_date, :timestamp, :index => true   #extracted arrival date

	column :price, :decimal       #price in rubles
	
	column :created_at, :timestamp #Время сохранения записи
	column :created_on, :timestamp #Дата сохранения записи

end
