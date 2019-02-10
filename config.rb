
# Include useful Ruby libraries
require 'yaml'

# Read Anu-configuration and make it accessible within Middleman
config[:anu] = YAML.load_file '.anu.yml'

# ARIA attributes for current links
activate :aria_current

# Directory indexes for pages (prettier urls); e.g. about.html -> about/index.html
activate :directory_indexes

# External pipeline for Middleman
activate :external_pipeline,
  name: :gulp,
  command: "./node_modules/gulp/bin/gulp.js #{build? ? 'build --production' : 'watch'} --silent",
  source: '.tmp/gulp',
  latency: 1

# Live reloading of assets (CSS, JS) during development
activate :livereload

# What to do when building
configure :build do
  # Suffixed hashes for assets; useful for caching
  activate :asset_hash
  # Minify HTML
  activate :minify_html

  # What to do after building
  after_build do |builder|
    # Run Gulp-task for compressing files and reporting their sizes
    builder.thor.run './node_modules/gulp/bin/gulp.js after --silent'
  end
end

# Ignore .keep-files; prevents empty folders in builds
ignore '/**/.keep'
# Ignore Sass-files; Gulp handles the pre-processing
ignore '/**/*.{sass,scss}'

# Ignore layouts for data-files
page '/*.json',   layout: false
page '/*.txt',    layout: false
page '/*.xml',    layout: false

# Ignore a directory index for the error page
page '/404.html', directory_index: false

# Where Middleman will look for assets
set :css_dir,    config[:anu]['folders']['stylesheets']
set :fonts_dir,  config[:anu]['folders']['fonts']
set :images_dir, config[:anu]['folders']['images']
set :js_dir,     config[:anu]['folders']['javascripts']

# Tell the Markdown-parser to allow more functionality
set :markdown,
  autolink: true,
  fenced_code_blocks: true,
  footnotes: true,
  highlight: true,
  smartypants: true,
  strikethrough: true,
  tables: true,
  with_toc_data: true

# Set the Markdown engine to Redcarpet
set :markdown_engine, :redcarpet

# Thanks, Rails
class Fixnum
  def ordinalize
    if (11..13).include?(self % 100)
      "#{self}th"
    else
      case self % 10
        when 1; "#{self}st"
        when 2; "#{self}nd"
        when 3; "#{self}rd"
        else    "#{self}th"
      end
    end
  end
end
