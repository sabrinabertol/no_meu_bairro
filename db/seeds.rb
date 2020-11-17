puts "Destroying everything..."
Neighbourhood.destroy_all

puts "Creating Neighbourhoods from the remote URL..."

response = RestClient.get('https://services.arcgis.com/1dSrzEWVQn5kHHyK/ArcGIS/rest/services/Limites_Cartografia/FeatureServer/1/query?where=1%3D1&outFields=*&f=pgeojson')
json = JSON.parse(response, symbolize_names: true)


json[:properties].each do |neighbourhood|
  name = properties[:name]

  puts "+ #{name}"

  Neighbourhood.create!(name: name)
end

puts "Done"

