require 'open-uri'
require 'nokogiri'
require 'net/http'
require "pry-byebug"


def destroy()
  puts "Destroying everything..."
  Comment.destroy_all
  Favourite.destroy_all
  Post.destroy_all
  Review.destroy_all
  Service.destroy_all
  User.destroy_all
  Neighbourhood.destroy_all

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
      email: Faker::Internet.email,
      neighbourhood: Neighbourhood.all.sample,
      )
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

# get an array in bairro and the correct name for find_by
def create_services(bairro, name_ok)

  puts "adding services to #{name_ok}... please wait"

  response_services = RestClient.get('https://services.arcgis.com/1dSrzEWVQn5kHHyK/arcgis/rest/services/RecenseamentoComercial/FeatureServer/13/query?where=1%3D1&outFields=*&outSR=4326&f=json')
  json_services = JSON.parse(response_services, symbolize_names: true)
  #byebug
  json_services[:features].each do |feature|
    service = feature[:attributes]
    geo = feature[:geometry]

    postal_code = "#{service[:COD_POST_4]}-#{service[:COD_POST_3]}"

    if bairro.include? postal_code 
      
      
      categories = ['business','food','city','people','transport']
      url = "http://lorempixel.com/1024/600/#{categories.sample}/#{rand(1..10)}"
      file = URI.open(url)



      puts "+ #{service[:NOME]} - #{service[:MORADA]}, #{service[:NUM_POLICIA]}, #{service[:COD_POST_4]}-#{service[:COD_POST_3]} => #{service[:TIPO]}"
      service = Service.create!(name: "#{service[:NOME]}",
                            address:"#{service[:MORADA]}, #{service[:NUM_POLICIA]}, #{service[:COD_POST_4]}-#{service[:COD_POST_3]} ",
                            phone: 0000000,
                            latitude:"#{geo[:y]}",
                            longitude:"#{geo[:x]}",
                            neighbourhood: Neighbourhood.find_by(name: name_ok),
                            category:"#{service[:TIPO]}",
                            user: User.first

                            )
                            
                            service.photos.attach(io: file, filename: "#{categories.sample}.png", content_type: 'image/png')
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

# acept a string with format for nokogiri 
# and the correct name for neighboord create 
def o_meu_bairro(o_meu_bairro, name_ok)
  puts "a obter os codigos postais do bairro #{name_ok} "

  url = "https://codigopostal.ciberforma.pt/dir/lista/por-freguesia/#{o_meu_bairro}-concelho-de-lisboa/todas-as-categorias/#"

  html_doc = Nokogiri::HTML(Net::HTTP.get(URI(url)))
  cp_list = []

 

  html_doc.search('.list-unstyled.long-list').each do |element|
    element.children.css('a').each do |cp|
      cp_list << cp.text[0..7]
     end
  end
  
  puts "codigos postais do #{o_meu_bairro} ok ! a criar serviços e reviews"

  create_services(cp_list, name_ok)
  
end


destroy()
create_neighbourhood()
create_users()
# + Santo António 
o_meu_bairro("santo-antonio","Santo António")
# + Parque das Nações
o_meu_bairro("parque-das-nacoes","Parque das Nações")
# + Marvila
o_meu_bairro("marvila","Marvila")
# + Ajuda
o_meu_bairro("ajuda","Ajuda")
# + Areeiro
o_meu_bairro("areeiro","Areeiro")
# + Santa Maria Maior
o_meu_bairro("santa-maria-maior","Santa Maria Maior")
# + Alvalade
o_meu_bairro("alvalade","Alvalade")
# + Belém
o_meu_bairro("belem","Belém")
# + Estrela
o_meu_bairro("estrela","Estrela")
# + Arroios
o_meu_bairro("arroios","Arroios")
# + Santa Clara
o_meu_bairro("santa-clara","Santa Clara")
# + Avenidas Novas
o_meu_bairro("avenidas-novas","Avenidas Novas")
# + Carnide
o_meu_bairro("carnide","Carnide")
# + São Domingos de Benfica
o_meu_bairro("sao-domingos-de-benfica","São Domingos de Benfica")
# + Beato
o_meu_bairro("beato","Beato")
# + Campolide
o_meu_bairro("campolide","Campolide")
# + Alcântara
o_meu_bairro("alcantara","Alcântara")
# + Campo de Ourique
o_meu_bairro("campo-de-ourique","Campo de Ourique")
# + São Vicente
o_meu_bairro("sao-vicente","São Vicente")
# + Olivais
o_meu_bairro("olivais","Olivais")
# + Misericórdia
o_meu_bairro("misericordia","Misericórdia")
# + Lumiar
o_meu_bairro("lumiar","Lumiar")
# + Penha de França
o_meu_bairro("penha-de-franca","Penha de França")
# + Benfica
o_meu_bairro("benfica","Benfica")

o_meu_bairro("santo-antonio", "Santo António")

o_meu_bairro("parque-das-nacoes", "Parque das Nações")

o_meu_bairro("areeiro", "Areeiro")

