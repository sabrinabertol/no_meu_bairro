puts "Destroying everything..."
Neighbourhood.destroy_all
Service.destroy_all
puts "Creating Neighbourhoods from the remote URL..."
User.create!(name:"basededados", password: "123456", email: "nbm@nbm.pt")
response = RestClient.get('https://services.arcgis.com/1dSrzEWVQn5kHHyK/ArcGIS/rest/services/Limites_Cartografia/FeatureServer/1/query?where=1%3D1&outFields=*&f=pgeojson')
json = JSON.parse(response, symbolize_names: true)
json[:features].each do |feature|
  name = feature[:properties]
  puts "+ #{name[:NOME]}"
  Neighbourhood.create!(name: "#{name[:NOME]}")
end
puts " Bairros OK"
response_services = RestClient.get('https://services.arcgis.com/1dSrzEWVQn5kHHyK/arcgis/rest/services/RecenseamentoComercial/FeatureServer/13/query?where=1%3D1&outFields=*&outSR=4326&f=json')
json_services = JSON.parse(response_services, symbolize_names: true)
#byebug
json_services[:features].each do |feature|
  service = feature[:attributes]
  geo = feature[:geometry]
  if service[:COD_POST_4] == "1070"
    puts "+ #{service[:NOME]} - #{service[:MORADA]}, #{service[:NUM_POLICIA]}, #{service[:COD_POST_4]}-#{service[:COD_POST_3]} => #{service[:TIPO]}"
    Service.create!(name: "#{service[:NOME]}",
                          address:"#{service[:MORADA]}, #{service[:NUM_POLICIA]}, #{service[:COD_POST_4]}-#{service[:COD_POST_3]} ",
                          phone: 0000000,
                          latitude:"#{geo[:x]}",
                          longitude:"#{geo[:y]}",
                          neighbourhood: Neighbourhood.find_by(name:"Campolide"),
                          category:"#{service[:TIPO]}",
                          user: User.first
                          )
      (1..5).each do |id|
    Review.create!(
    content: Faker::Movies::Ghostbusters.quote,
    rating: rand(1..5),
    user: User.first,
    service:Service.last,
      )
  end
  end
end
puts " services OK"
puts "Creating Users"
puts "Creating Services"