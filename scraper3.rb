require 'nokogiri'
require 'rest-client'
require File.expand_path('get.rb', __dir__)
require File.expand_path('car.rb', __dir__)

class Result
  def write
    headers = %w[Brand Title Year Fuel]
    CSV.open('results_1.csv', 'w', write_headers: true, headers: headers) do |csv|
      get1 = Get.new
      car1 = Car.new
      while get1.page_var <= 5
        puts get1.page_var
        n = 0
        get1.htm2l = RestClient.get("https://www.otomoto.pl/osobowe?page=#{get1.page_var}")
        while n < 32
          get1.get_title(n)
          get1.get_brand(n)
          get1.get_year(n)
          get1.get_fuel_type(n)
          n += 1
          car1.save(get1.brand, get1.title, get1.yearf, get1.fuel)
          csv << car1.row
        end
        get1.page_var += 1
      end
    end
  end
end

res = Result.new
res.write
