require "csv"
require "httparty"

class ImportEarthquakes
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
    # url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_week.csv"
    url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv"
    response = HTTParty.get(url).body

    rows = response.split("\n").map do |row|
      row.split(",")
    end

    rows[1..-1]
  end
end
