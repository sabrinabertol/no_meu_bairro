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


#  hash_seed[:service_names] = ["Flores da Deolinda", "Mestre das Chaves", "Sapataria Estrela", "Nascer do Sol", "Naturalis"]
  
hash_seed.each do |key, value|

  user = User.create!(

    hash_seed = Hash.new (
      hash_seed[:name] = %w(Ruben Romulo Sabrina Luis Felipe)
      hash_seed[:email] = %w(ruben@gmail.com romulo@gmail.com sabrina@gmail.com luis@gmail.com felipe@gmail.com)
      hash_seed[:password] = "123456"
      hash_seed[:neighbourhood] = Neighbourhood.first
  ))

  # service = Service.create!(service.name)
 

service_seed.each do |key, value|

  service = Service.create! (

    service_seed = Service.new (
      service_seed[:name] = %w(Flores da Deolinda Mestre das Chaves Sapataria Estrela Nascer do Sol Naturalis)
      service_seed[:user] = User.first
      service_seed[:neighbourhood] = Neighbourhood.first
  )) 
  
end
  
  # Neighbourhood.find_by(name: "Baixa")
  
  
  review_seed.each do |key, value|
    
    review = Review.create! (
      
      review_seed = Review.new (
        review_seed[:name] = %w(Flores da Deolinda Mestre das Chaves Sapataria Estrela Nascer do Sol Naturalis)
          review_seed[:user] = User.first
          review_seed[:neighbourhood] = Neighbourhood.first
          
          review.save!

end