require "./import_earthquakes.rb"
require "keen"

ENV["KEEN_PROJECT_ID"] = "572dfdae3831443195b2f30c"
ENV["KEEN_MASTER_KEY"] = "D3EEB4BCCB71113FF0790CF84D07FF7B60DF15B38FA014D0DB770FB5E38AA06E"
ENV["KEEN_WRITE_KEY"] = "832afdd2d98d4290b5a76ac4a70a373d31c273f502b73999458398d053c68326a7210b976c86155feef1b28e648bf956596eca4f47c8e051c1908d512fb46721005036b3d52b9fecf34d3c3e05bb31d0f5155a649d1358e0804c89916d12b378"
ENV["KEEN_READ_KEY"] = "5de7f166da2e36f6c8617347a7a729cfda6d5413db8d88d7f696b61ddaa4fe1e5cdb7d019de9bb0ac846d91e83cdac01e973585d0fba43fadf92f06a695558b890665da824a0cf6a946ac09f5746c9102d228a1165323fdd0c52c92b80e78eca"

task :import do
  # Keen.delete(:earthquakes)
  importer = ImportEarthquakes.new()
  eqs = importer.week_earthquakes_data

  eqs.each do |eq|
    existing = Keen.count(:earthquakes,
               timeframe: "last_40_days",
               filters: [{
                 property_name: "id",
                 operator: "eq",
                 property_value: eq[11]
    }])
    if existing > 0
      next
    end

    body = {
      depth: eq[3].to_f,
      mag: eq[4].to_f,
      magType: eq[5].to_f,
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
