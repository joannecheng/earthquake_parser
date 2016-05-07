require "./import_earthquakes.rb"
require "keen"

task :import do
  Keen.delete(:earthquakes)
  importer = ImportEarthquakes.new()
  eqs = importer.week_earthquakes_data

  #puts eqs[0..20].inspect

  eqs.each do |eq|
    body = {
      depth: eq[3].to_f,
      mag: eq[4].to_f,
      magType: eq[5],
      nst: eq[6].to_i,
      gap: eq[7].to_f,
      dmin: eq[8].to_f, # horiz dist - epicenter to nearest station
      rms: eq[9].to_f,
      net: eq[10], # id of data contrib
      id: eq[11],
      place: eq[13],
      type: eq[14],
      status: eq[19],
      keen: {
        timestamp: eq[0],
        location: {
          coordinates: [eq[2].to_f, eq[1].to_f]
        }
      }
    }
    Keen.publish(:earthquakes, body)
  end
end
