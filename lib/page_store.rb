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
    # binding.pry
  end

  def self.create(data={})
    pages.insert(data)
  end

  def self.update(path, data={})
    pages.where(:path => path).update(data)
  end

end
