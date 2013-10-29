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
    assert_match /In short, Bikes Rule! /, last_response.body
  end

  def test_it_finds_mission_values_page
    get '/about/mission-vision-and-values'
    assert last_response.ok?
    assert_match /We envision a world /, last_response.body
  end

  def test_it_finds_contact_and_hours
    get '/about/contact'
    assert last_response.ok?
    assert_match /We are closed Sundays November-March./, last_response.body
  end

  def test_it_finds_history_page
    get '/about/history'
    assert last_response.ok?
    assert_match /planted long, long ago/, last_response.body
  end

  def test_it_finds_privacy_policy
    get 'about/privacy-policy'
    assert last_response.ok?
    assert_match /For further information/, last_response.body
  end

  def test_it_finds_staff_and_board
    get 'about/staff-board'
    assert last_response.ok?
    assert_match /all these friendly people/, last_response.body
  end

  def test_it_finds_bike_shoppe
    get 'bike-shop'
    assert last_response.ok?
    assert_match /Bo Bike thingy /, last_response.body
  end

  def test_it_finds_retail
    get '/bike-shop/retail'
    assert last_response.ok?
    assert_match /a dizzying array of styles/, last_response.body
  end

  def test_it_finds_service_menu
    get '/bike-shop/service'
    assert last_response.ok?
    assert_match /-Lube Drivetrain/, last_response.body
  end

  def test_it_finds_xtracycle
    get '/bike-shop/xtracycle'
    assert last_response.ok?
    assert_match /20" Specialized Hardrock/, last_response.body
  end

  def test_it_finds_calendar
    get '/events/calendar'
    assert last_response.ok?
    assert_match /Calendar/, last_response.body
  end

  def test_it_finds_park_hill
    get '/events/park-hill'
    assert last_response.ok?
    assert_match /Jacqui Shumway/, last_response.body
  end

  def test_it_finds_links
    get '/links'
    assert last_response.ok?
    assert_match /Please check out our/, last_response.body
  end

  def test_


end
