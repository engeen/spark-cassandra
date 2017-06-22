namespace :graph do
  desc "Generate graph"
  task small: :environment do
    @cities   = City.where("iata is not ?", nil).limit(50).to_a
    @periods  = 0..5


    @periods.each do |period|
      @cities.each_with_index do |c, index|

        (5..20).to_a.sample.times do 
          _random_target = ((0..49).to_a - [index]).sample
          _dep = Faker::Time.between(period.days.since, (period+1).days.since, :all)
          _arr = rand(300).minutes.since(_dep)
          _price = (_arr-_dep)*(1.0+rand)

          ScheduleNode.create(
            f_id: c.id, 
            to_id: @cities[_random_target].id,
            from_location: c.name, 
            to_location: @cities[_random_target].name, 
            cruise_num: Faker::Code.asin, 
            price: _price,
            departure_time: _dep,
            arrival_time: rand(300).minutes.since(_dep)
         )

        end #cruises
        pp "City #{c.name} generated"
      end #cities
      pp "====> Period #{period} days generated"
    end #periods

  end

end

namespace :graph do

  desc "Generate distances"
  task generate_distances: :environment do
    @cities   = City.where("iata is not ?", nil).to_a
    @total_large_cities = @cities.length
    @total_small_cities = City.where("iata is ?", nil).count
    @cluster_size = @total_small_cities / @total_large_cities

    pp "Found large cities: #{@total_large_cities}"
    pp "Found small cities: #{@total_small_cities}"
    pp "Lets cluster size eq: #{@cluster_size}"
    pp "Generating large cities distances..."

    @cities.each_with_index do |from, index|
      pp "=>Processing #{from.name}..."
      counter = 0
      @cities.each_with_index do |to, big_to_index|
        next if big_to_index <= index
        _d = Distance.find_or_create_by(from_id: from.id, to_id: to.id)
        _d.distance = rand(1000..5000)
        _d.save!
        counter +=1
      end
      pp "=> Completed #{counter} distances to another large cities"

      #small cluster emulation
      @cluster = City.where("iata is ?", nil).limit(@cluster_size).offset(index * @cluster_size)
      "=>Processing cluster #{index} with #{@cluster.count} small cities...."

        counter = 0
      @cluster.each_with_index do |small_to, small_index|
        #from main city in cluster
        _d = Distance.find_or_create_by(from_id: from.id, to_id: small_to.id)
        _d.distance = rand(10..1000)
        _d.is_small = true
        _d.save!
        counter += 1

        #between each other
        @cluster.each_with_index do |cluster_to, cluster_index|
          next if cluster_index <= small_index
          #from main city in cluster
          _d = Distance.find_or_create_by(from_id: small_to.id, to_id: cluster_to.id)
          _d.distance = rand(10..2000)
          _d.is_small = true
          _d.save!
          counter += 1
        end
      end
      pp "=>Distances for cluster from #{from.name} to small cities completed with #{counter} routes"
      pp ""

    end
  end
end

namespace :graph do

  desc "Generate medium graph"
  task medium: :environment do
    @cities   = City.all.to_a
    @periods  = 0..5


    #each period
    @periods.each do |period|

      #each cities
      @cities.each_with_index do |c, index|

        _routes_counter = 0
        _rails_counter = 0
        _auto_counter = 0
        _avia_counter = 0

        #each city routes
        @bi_dir_routes = Distance.where("from_id=? or to_id=?", c.id, c.id)
        @bi_dir_routes.each do |rt|

          #two directions
          [false, true].each do |backward|

            from = City.find(backward ? rt.to_id : rt.from_id)
            to   = City.find(backward ? rt.from_id : rt.to_id)

            _dep = Faker::Time.between(period.days.since, (period+1).days.since, :all)
            _trasport_types = %w(rail avia auto)
            _trasport_types = %w(rail auto) if rt.is_small?

            #each transport type
            _trasport_types.each do |transport_type|

              _cruise_number = rand(3..10) if transport_type=='avia' 
              _cruise_number = rand(3..5) if transport_type=='rail'
              _cruise_number = rand(5..6) if transport_type=='auto'

              #each cruises
              _cruise_number.times do 
                _arr = (rt.distance / 700.0 * 3600.0).round.minutes.since(_dep) if transport_type == 'avia'
                _arr = (rt.distance / 100.0 * 3600.0).round.minutes.since(_dep) if transport_type == 'rail'
                _arr = (rt.distance / 70.0 * 3600.0).round.minutes.since(_dep) if transport_type == 'auto'

                _price = rt.distance * 4 if transport_type == 'avia'
                _price = rt.distance * 3 if transport_type == 'rail'
                _price = rt.distance * 1.5 if transport_type == 'auto'

                  ScheduleNode.create(
                    f_id: from.id, 
                    to_id: to.id,
                    from_location: from.name, 
                    to_location: to.name, 
                    cruise_num: Faker::Code.asin, 
                    price: _price,
                    departure_time: _dep,
                    arrival_time: _arr,
                    transport_type: transport_type
                 )
                 _rails_counter += 1 if  transport_type=='rail'
                 _auto_counter += 1 if  transport_type=='auto'
                 _avia_counter +=1 if  transport_type=='avia'
              end
            end
            _routes_counter += 1
          end #directions
        end
        pp "City #{c.name} generated with #{_routes_counter} routes: #{_rails_counter} rails, #{_auto_counter} auto, #{_avia_counter} avia"

      end #cities
      pp "====> Period #{period} days generated"
    end #periods
  end


end