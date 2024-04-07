class MetadataService

  def initialize(url:)
    @parser = HtmlParserService.new(url: url)
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

    class MetadataResponse
      attr_reader :title, :description, :image

      def initialize(title:, description:, image:)
        self.title = title
        self.description = description
        self.image = image
      end

      private
        attr_writer :title, :description, :image
    end

end
