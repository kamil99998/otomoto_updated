require 'csv'

class Car
  attr_accessor :brand, :title, :yearf, :fuel, :row

  def initialize
    @brand = ''
    @title = ''
    @yearf = ''
    @fuel = ''
  end

  def save(return_brands, return_titles, return_years, return_fuels)
    brand2 = return_brands.to_s.tr('"', '').tr('[', '').tr(']', '')
    fuel2 = return_fuels.to_s.tr('"', '').tr('[', '').tr(']', '')
    title2 = return_titles.to_s.tr('"', '').tr('[', '').tr(']', '')
    @row = [brand2, title2, return_years, fuel2]
  end
end
