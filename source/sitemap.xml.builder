xml.instruct!
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  pages = sitemap.resources.select do |page|
    # Select all HTML-files that are not 404.html
    page.path =~ /\A((?!404).)*\.html\z/
  end

  pages.each do |page|
    xml.url do
      # Include the url for each selected page
      xml.loc "#{config[:anu]['url']}#{page.url}"
    end
  end
end
