class MetadataJob < ApplicationJob
  queue_as :default

  def perform(id)
    link = Link.find_by_code(id)
    puts "Executing MetadataJob for link with url: #{link.url}"
    attributes = Metadata.retrieve_from(link.url).attributes

    link.update(attributes)
    link.broadcast_replace_to(link)
  end

end
