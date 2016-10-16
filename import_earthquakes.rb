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
    CSV.parse(response, headers: true)
  end
end
