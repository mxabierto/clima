require 'csv'

class LoadController < ApplicationController
  def index
  end

  def country_variables
    csv = CSV.new(File.new('conjunto_landing.csv'), :headers => true, :header_converters => :symbol)
    CountryVariable.create_all(csv)
    redirect_to load_index_url, notice: 'Se cargaron correctamente'
  end

  def page1
    # obtener json con los siguientes datos por cada una de las variables:
    # 1. la posición de mexico en el ranking
    # 2. % de mexico sobre el total
    csv = CSV.new(File.new('conjunto_landing_3_rows.csv'), :headers => true, :header_converters => :symbol)
    csv.to_a.each do |row|
      puts "mmmmmmmmmm: #{row.class.name}"
    end
    # obtener json para la gráfica (el emisiones_v2.csv)
  end
end
