ENV['RACK_ENV'] = 'test'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'page_store'

class PageStoreTest < Minitest::Test

  def setup

  end

  def teardown
    PageStore.destroy_database_contents
  end

  def test_it_exists
    assert PageStore
  end

  def test_it_creates_database
    assert PageStore.database
  end

  def test_it_creates_pages_table
    assert PageStore.database.schema(:pages)
  end

  def test_it_saves_row
    assert_equal 0, PageStore.pages.count
    PageStore.create(:path => "path/woah", :text => "yo yo yo yo")
    assert_equal 1, PageStore.pages.count
  end

  def test_it_can_find_by_path
    PageStore.create(:path => "satan", :text => "rawr")
    PageStore.create(:path => "path/woah", :text => "yo yo yo yo")
    PageStore.create(:path => "santa", :text => "ho ho ho")
    row = PageStore.find("path/woah")
    assert_equal "yo yo yo yo", row[:text]
  end

  def test_it_can_update_db
    PageStore.create(:path => "santa", :text => "ho ho ho")
    PageStore.update("santa", :text => "howdy dowdy doo")
    row = PageStore.find("santa")
    assert_equal "howdy dowdy doo", row[:text]
  end

end
