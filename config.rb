activate :directory_indexes
activate :gzip
activate :sprockets

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_html
end

page "/404.html", :directory_index => false

set :build_dir, "build"
set :css_dir,   "assets/css"
set :js_dir,    "assets/js"

set :markdown_engine, :redcarpet
set :markdown,
    :fenced_code_blocks => true,
    :smartypants => true
