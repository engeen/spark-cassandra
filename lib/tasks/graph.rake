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