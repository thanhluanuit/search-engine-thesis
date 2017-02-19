require 'nokogiri'
require 'open-uri'

module Documents
  class UpdateContent
    class << self
      def call(document)
        return if document.url.include?("twitter.com") || document.url.include?("instagram.com")

        begin
          path = URI.parse(URI.encode(document.url))
          html_content = Nokogiri::HTML(open(path))
          html_content.search("script").remove
          html_content.search("style").remove

          document.update_attributes(
            title: html_content.title,
            content: html_content.content.gsub("\n", " ").squish
          )
        rescue OpenURI::HTTPError => ex
          document.destroy
        rescue => error
        end
      end
    end
  end
end
