puts "Destroying everything..."
Neighbourhood.destroy_all

puts "Creating Neighbourhoods from the remote URL..."

response = RestClient.get('https://services.arcgis.com/1dSrzEWVQn5kHHyK/ArcGIS/rest/services/Limites_Cartografia/FeatureServer/1/query?where=1%3D1&outFields=*&f=pgeojson')
json = JSON.parse(response, symbolize_names: true)


json[:features].each do |feature|
  name = feature[:properties]

  puts "+ #{name[:NOME]}"

  Neighbourhood.create!(name: "#{name[:NOME]}")
end

puts "Done"
#
