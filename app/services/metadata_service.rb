class MetadataService

  def initialize(url:)
    @parser = HtmlParserService.new(url: url)
  end

  def self.instance(url:)
    new(url: url)
  end

  def response
    MetadataResponse.new(
      title: title,
      description: description,
      image: image
    )
  end

  private
    def title
      @parser.css("title")
    end

    def description
      @parser.extract_meta('name', 'description')
    end

    def image
      @parser.extract_meta('property', 'og:image')
    end

end
