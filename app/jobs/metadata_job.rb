class MetadataJob < ApplicationJob
  queue_as :default

  def perform(id)
    link = Link.find_by_code(id)
    puts "Executing MetadataJob for link with url: #{link.url}"
    response = MetadataService.instance(url: link.url).response

    link.update(
      title: response.title,
      description: response.description,
      image: response.image
    )
    link.broadcast_replace_to(link)
  end

end
