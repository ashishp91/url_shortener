require "open-uri"

class Metadata
  attr_reader :doc

  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  def self.retrieve_from(url)
    new(URI.open(url))
  rescue StandardError
    new
  end

  def attributes
    {
      title: title,
      description: description,
      image: image
    }
  end

  def title
    doc.at_css("title")&.text
  end

  def description
    extract_meta('name', 'description')
  end

  def image
    extract_meta('property', 'og:image')
  end

  private
    def extract_meta(meta_type, meta_name)
      meta_description = doc.at_css("meta[#{meta_type}='#{meta_name}']")
      return nil if meta_description.nil? || !meta_description.attributes.key?("content")

      meta_description.attributes['content'].text
    end

end
