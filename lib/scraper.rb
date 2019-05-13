require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_index = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      new_hash = {}
      new_hash[:name] = card.css("h4.student-name").text
      new_hash[:location] = card.css("p.student-location").text
      new_hash[:profile_url] = card.css("a").attribute("href").value
      scraped_index << new_hash
    end
    scraped_index
end

  def self.scrape_profile_page(profile_url)
      new_hash = {}
      doc = Nokogiri::HTML(open(profile_url))
      doc.css("div.social-icon-container a").each do |this|
        if this.attribute("href").value.include?("twitter")
          new_hash[:twitter] = this.attribute("href").value
        elsif this.attribute("href").value.include?("linkedin")
          new_hash[:linkedin] = this.attribute("href").value
        elsif this.attribute("href").value.include?("github")
          new_hash[:github] = this.attribute("href").value
        else
          new_hash[:blog] = this.attribute("href").value
      end
    end
      new_hash[:profile_quote] = doc.css("div.profile-quote").text
      new_hash[:bio] = doc.css("div.description-holder p").text
      new_hash
 end
  end

end

