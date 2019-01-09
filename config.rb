require 'yaml'

activate :directory_indexes
activate :sprockets

configure :build do
  activate :brotli
  activate :gzip

  activate :asset_hash
  activate :minify_css
  activate :minify_html
end

if File.exist? 'config.yml'
  config = YAML.load_file 'config.yml'

  activate :deploy do |deploy|
    deploy.deploy_method = :rsync
    deploy.clean = true

    deploy.host = config['host']
    deploy.path = config['path']
    deploy.user = config['user']
  end
end

page '/404.html', :directory_index => false

set :build_dir, 'build'
set :css_dir,   'assets/css'
set :js_dir,    'assets/js'

set :markdown_engine, :redcarpet
set :markdown,
    :fenced_code_blocks => true,
    :smartypants => true
