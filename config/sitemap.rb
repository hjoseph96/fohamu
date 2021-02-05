# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.fohamu.org"
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.create do
  # The root path '/' and sitemap index file are added automatically for you.

  add '/donate', :changefreq => 'daily', :priority => 1.0
  add '/fbla', :changefreq => 'daily', :priority => 0.9
  add '/our_school', :changefreq => 'daily', :priority => 0.7
  add '/about_us', :changefreq => 'daily', :priority => 0.6


  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   endcom
end
