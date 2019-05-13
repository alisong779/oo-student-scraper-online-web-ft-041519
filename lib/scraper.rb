require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_hash = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "http://students.learn.co/" + student.css("a").attribute("href")
      }
      students_hash << hash
    end
      students_hash
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

