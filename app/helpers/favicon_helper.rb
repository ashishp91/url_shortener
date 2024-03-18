module FaviconHelper

  def favicon_image_tag(domain, **options)
    image_tag domain_based_favicon(domain), **options
  end

  def domain_based_favicon(domain, **options)
    "https://www.google.com/s2/favicons?domain=#{domain}"
  end

end
