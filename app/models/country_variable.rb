class CountryVariable < ActiveRecord::Base
  validates_presence_of :variable, :country_name, :country_code, :year

  def self.create_all(csv)
    csv.each_with_index do |row, i|
      create!(
          variable: row[0],
          country_name: row[1],
          country_code: row[2],
          year: row[3][2,5],
          value: row[4] == '..' ? nil : row[4].to_f
      )
      #break if i == 999
    end
    return true
  end

  def self.jsonize

  end
end
