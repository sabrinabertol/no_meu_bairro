require 'open-uri'
require 'nokogiri'
require 'net/http'
require "pry-byebug"

def cp_from(o_meu_bairro)

  url = "https://codigopostal.ciberforma.pt/dir/lista/por-freguesia/#{o_meu_bairro}-concelho-de-lisboa/todas-as-categorias/#"

  html_doc = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  cp_list = []

 

  html_doc.search('.list-unstyled.long-list').each do |element|
    element.children.css('a').each do |cp|
      cp_list << cp.text[0..7]
     end
    puts cp_list
  end

  puts cp_list 
end


def destroy()
  puts "Destroying everything..."

  User.destroy_all
  Neighbourhood.destroy_all
  Service.destroy_all
  Review.destroy_all

  puts "All destroyed..."
end


def create_users()
  puts "creating admin ..."

  User.create!(name:"admin", password: "123456", email: "admin@admin.pt")
  puts "creating other users.... "

  (1..20).each do |id|
    User.create!(
      name:Faker::FunnyName.two_word_name, 
      password: "123456", 
      email: Faker::Internet.email) 
  end

  puts ".....................users ok"
end


def create_neighbourhood()
  puts "Creating Neighbourhoods from the remote URL..."

  response = RestClient.get('https://services.arcgis.com/1dSrzEWVQn5kHHyK/ArcGIS/rest/services/Limites_Cartografia/FeatureServer/1/query?where=1%3D1&outFields=*&f=pgeojson')
  json = JSON.parse(response, symbolize_names: true)
  json[:features].each do |feature|
    name = feature[:properties]
    puts "+ #{name[:NOME]}"
    Neighbourhood.create!(name: "#{name[:NOME]}")
  end

  puts "...........Neighbourhoods ok"
end


def create_services(ceplist, name)

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
                            latitude:"#{geo[:y]}",
                            longitude:"#{geo[:x]}",
                            neighbourhood: Neighbourhood.find_by(name:"Campolide"),
                            category:"#{service[:TIPO]}",
                            user: User.first
                            )

      create_reviews()  
    end
  end
  puts " services OK"
end

def create_reviews()
  puts "adding somme reviews"
  (1..5).each do |id|
    Review.create!(
    content: Faker::Movies::Ghostbusters.quote,
    rating: rand(1..5),
    user: User.all.sample,
    service:Service.last,
      )
  end

  puts "reviews ok"
end