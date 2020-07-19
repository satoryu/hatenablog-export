# frozen_string_literal: true

require 'erb'
require 'hatenablog'
require 'optparse'

opt = OptionParser.new
opt.on('-u USER_ID', '--user_id USER_ID') { |v| v }
opt.on('-b BLOG_ID', '--blog_id BLOG_ID') { |v| v }
opt.on('-k API_KEY', '--api_key API_KEY') { |v| v }

params = {}
opt.parse!(ARGV, into: params)

client = Hatenablog::Client.new do |config|
  config.auth_type = 'basic'
  config.api_key = params[:api_key]
  config.user_id = params[:user_id]
  config.blog_id = params[:blog_id]
end

class Post
  def initialize(entry)
    @entry = entry
  end

  def title
    @entry.title
  end

  def categories
    @entry.categories
  end

  def content
    @entry.content
  end

  def updated
    @entry.updated
  end

  def draft?
    @entry.draft?
  end

  def formatted_content
    @entry.formatted_content
  end

  def filename
    name = slug || title.gsub(/(\s|[":,#])+/, '-')
    return name if @entry.draft?
    return "#{@entry.updated.strftime('%Y-%m-%d')}-#{name}" if @entry.updated

    name
  end

  def slug
    return unless @entry.uri

    slug = @entry.uri.split('/').last
    return if slug =~ /\A\d+\Z/

    slug
  end

  def render
    ERB.new(<<~"TEMPLATE").result(binding)
    ---
    title: "<%= title %>"
    date: <%= updated.strftime('%Y-%m-%d') %>
    slug: "<%= slug || title %>"
    category: blog
    tags: [<%= categories.join(',') %>]
    ---
    <%= formatted_content %>
    TEMPLATE
  end
end

client.all_entries.each do |entry|
  post = Post.new(entry)

  dir_name = post.draft? ? '_drafts' : '_posts'
  destination = File.join(dir_name, post.filename)
  File.open("#{destination}.md", 'w') do |f|
    f.write(post.render)
  end
end
