require "csv"
require "httparty"

class ImportEarthquakes
  def initialize(local = true)
    @local = local
  end

  def headers
    [
      "time", "latitude", "longitude", "depth",
      "mag", "magType", "nst", "gap",
      "dmin", "rms", "net", "id",
      "updated", "place", "type", "horizontalError",
      "depthError", "magError", "magNst", "status",
      "locationSource", "magSource"
    ]
  end

  def week_earthquakes_data
    if @local
      f = File.open("all_week.csv", "r")
      response = f.read
      f.close()
    else
      url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv"
      response = HTTParty.get(url).body
    end

    rows = response.split("\n").map do |row|
      row.split(",")
    end

    rows[1..-1]
  end
end
