require "pry-byebug"

class NewsService

    def self.call
        
        New.destroy_all
        response = RestClient.get('https://www.agendalx.pt/wp-json/agendalx/v1/events')
        json = JSON.parse(response, symbolize_names: true)
        agenda=[]
        json.each do |feature|
            agenda << New.create!(
                url: "#{feature[:link]}",
                title: "#{feature[:title][:rendered]}",
                content: "#{feature[:description]} ",
                photourl: "#{feature[:featured_media_large]}"
            )
        end
        return agenda
    end
end
