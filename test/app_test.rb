ENV['RACK_ENV'] = 'test'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/app'
require 'rack/test'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    CloneWarsApp
  end

  def test_it_find_the_homepage
    get '/'
    assert last_response.ok?
  end

  def test_it_finds_the_about_page
    get '/about'
    assert last_response.ok?
  end

  def test_it_finds_mission_values_page
    get '/about/mission-vision-values'
    assert last_response.ok?
  end

end
