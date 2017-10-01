config = YAML::load(File.read("config.yml"))

activate :directory_indexes
activate :gzip
activate :sprockets

activate :deploy do |deploy|
  deploy.deploy_method = :rsync

  deploy.clean = config["clean"]
  deploy.host  = config["host"]
  deploy.path  = config["path"]
  deploy.port  = config["port"]
  deploy.user  = config["user"]
end

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_html
end

page "/assets/error.html", :directory_index => false

set :build_dir, "build"
set :css_dir,   "assets/css"
set :js_dir,    "assets/js"

set :markdown_engine, :redcarpet
set :markdown,
    :fenced_code_blocks => true,
    :smartypants => true