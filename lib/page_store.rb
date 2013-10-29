require 'sequel'
require 'redcarpet'
require 'reverse_markdown'

class PageStore

  def self.database
    if ENV['RACK_ENV'] == 'test'
      @database ||= Sequel.sqlite('db/test/database.sqlite3')
    else
      @database ||= Sequel.sqlite('db/database.sqlite3')
    end
  end

  def self.pages
    database.from(:pages)
  end

  def self.destroy_database_contents
    if ENV['RACK_ENV'] == 'test'
      pages.delete
    end
  end

  def self.find(path)
    pages[:path => path]
  end

  def self.save(data={})
    pages.insert(data)
  end

  def self.update(path, data={})
    pages.where(:path => path).update(data)
  end

  def self.convert_to_html
    TextFilter.to_html(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        :autolink => true,
                                        :space_after_headers => true)

  end

end
