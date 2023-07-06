require 'rest-client'
require 'nokogiri'


class Get
    attr_accessor :brand
    attr_accessor :title
    attr_accessor :yearf
    attr_accessor :fuel
    attr_accessor :pageVar
    attr_accessor :htm2l

    def initialize
        @pageVar = 1
        @htm2l = ''
        @@array = Array.new
        @@brandSuperFinal = Array.new
        @@year = Array.new
        @@fuelSuperFinal = Array.new
    end


    def get_title(nn)
            doc = Nokogiri::HTML.parse(@htm2l)
            docText = doc.text
            name = docText.scan(/Car","name":"(.*?)","brand":/m)
            @title = name[nn]
        return name[nn].to_s
    end

    def get_brand(nn)
        doc = Nokogiri::HTML.parse(@htm2l)
        docText = doc.text
        testBrand = docText.scan(/Marka pojazdu(.*?)__typename/m).to_s
        brand = testBrand.scan(/:(.*?)",/m)
        brandFinal = brand.join(", ")
        @@brandSuperFinal = brandFinal.scan(/"(.*?)[^a-zA-Z]/m)
        @@brandSuperFinal.pop(8)
        @brand = @@brandSuperFinal[nn]
    return @@brandSuperFinal[nn].to_s
    end

    def get_year(nn)
        doc = Nokogiri::HTML.parse(@htm2l)
        docText = doc.text
        testNumber = docText.scan(/Rok produkcji(.*?)__typename/m).to_s
        @@year = testNumber.scan(/\b\d{4}\b/)
        @yearf = @@year[nn]
    return @@year[nn].to_s
    end

    def get_fuel_type(nn)
        doc = Nokogiri::HTML.parse(@htm2l)
        docText = doc.text
        testFuel = docText.scan(/Rodzaj paliwa(.*?)__typename/m).to_s
        fuel = testFuel.scan(/":(.*?)",/m).to_s
        fuelFinal = fuel.scan(/"(.*?)[^a-zA-Z]/m).to_s
        @@fuelSuperFinal = fuelFinal.scan(/\b(.*?)\b"]/m)  
        @@fuelSuperFinal.pop(6)
        @fuel = @@fuelSuperFinal[nn]
    return @@fuelSuperFinal[nn].to_s
    end
end
