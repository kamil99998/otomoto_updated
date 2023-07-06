require 'nokogiri'
require 'rest-client'
require File.expand_path('../get.rb', __FILE__)
require File.expand_path('../car.rb', __FILE__)

# Wszystko rozbić na klasy -> OK
# Nie ma być metod poza klasą (wszystkie moetody w klasie/klasach) -> OK
# attr_accessor -> OK
# Nazwy metod poprawić -> OK
# Wyszukiwanie po znacznikach HTML -> Poprawione w wyszukiwaniu tytułu -> OK
# Brak zmiennych globalnych -> OK

class Result
    def write
        headers = ["Brand", "Title", "Year", "Fuel"]
        CSV.open("results_1.csv", "w", write_headers: true, headers: headers) do |csv|
            get1 = Get.new
            car1 = Car.new
            while get1.pageVar <= 5
                puts get1.pageVar
                n=0
                get1.htm2l = RestClient.get("https://www.otomoto.pl/osobowe?page=#{get1.pageVar.to_s}")
                while n<32
                    get1.get_title(n)
                    get1.get_brand(n)
                    get1.get_year(n)
                    get1.get_fuel_type(n)
                    n += 1
                    car1.save(get1.brand, get1.title, get1.yearf, get1.fuel)
                    csv << car1.row
                end
                get1.pageVar += 1
            end
        end
    end
end

res = Result.new
res.write

