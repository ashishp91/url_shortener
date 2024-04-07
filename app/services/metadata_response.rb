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
