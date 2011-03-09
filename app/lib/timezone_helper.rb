
module TimezoneHelper
  def timezone_by_ip(ipaddress)
    res = Geokit::Geocoders::IpGeocoder.geocode(ipaddress)
    if res.success
      timezone = Geonames::WebService.time(res.lat, res.lng)
      ActiveSupport::TimeZone.new(timezone.timezone_id)
    end
  end
end
