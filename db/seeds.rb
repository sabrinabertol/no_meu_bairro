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