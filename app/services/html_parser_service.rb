require "open-uri"

class HtmlParserService

  def initialize(url:)
    @html = Nokogiri::HTML(URI.open(url))
  end

  def css(prop)
    @html.at_css(prop)&.text
  end

  def extract_meta(meta_type, meta_name)
    meta_description = @html.at_css("meta[#{meta_type}='#{meta_name}']")
    return nil if meta_description.nil? || !meta_description.attributes.key?("content")

    meta_description.attributes['content'].text
  end
end
