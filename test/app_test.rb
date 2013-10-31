
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
    assert_match /our Volunteer Mechanics/, last_response.body
  end

  def test_it_finds_the_about_page
    get '/about'
    assert last_response.ok?
    assert_match /break down social barriers/, last_response.body
  end

  def test_it_finds_mission_values_page
    skip
    get '/about/mission-vision-and-values'
    assert_match /We envision a world /, last_response.body
  end

  def test_it_finds_contact_and_hours
    skip
    get '/about/contact'
    assert last_response.ok?
    assert_match /We are closed Sundays November-March./, last_response.body
  end

  def test_it_finds_board_of_directors
    get '/about/board-of-directors'
    assert last_response.ok?
    assert_match /Guy Morissette is a life-/, last_response.body
  end

  def test_it_finds_history_page
    skip
    get '/about/history'
    assert last_response.ok?
    assert_match /planted long, long ago/, last_response.body
  end

  def test_it_finds_privacy_policy
    skip
    get 'about/privacy-policy'
    assert last_response.ok?
    assert_match /For further information/, last_response.body
  end

  def test_it_finds_staff_and_board
    skip
    get 'about/staff-board'
    assert last_response.ok?
    assert_match /all these friendly people/, last_response.body
  end

  def test_it_finds_bike_shoppe
    skip
    get 'bike-shop'
    assert last_response.ok?
    assert_match /Bo Bike thingy /, last_response.body
  end

  def test_it_finds_retail
    skip
    get '/bike-shop/retail'
    assert last_response.ok?
    assert_match /a dizzying array of styles/, last_response.body
  end

  def test_it_finds_service_menu
    skip
    get '/bike-shop/service'
    assert last_response.ok?
    assert_match /-Lube Drivetrain/, last_response.body
  end

  def test_it_finds_xtracycle
    skip
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

  def test_it_finds_bidness_partners
    get '/links/business-partners'
    assert last_response.ok?
    assert_match /nto the hands o/, last_response.body
  end

  def test_it_finds_homies
    get '/links/friends'
    assert last_response.ok?
    assert_match /Friends/, last_response.body
  end

  def test_it_finds_we_love
    get '/links/we-love'
    assert last_response.ok?
    assert_match /Thank you to Smartwool/, last_response.body
  end

  def test_it_finds_programs
    get '/programs'
    assert last_response.ok?
    #assert_match /Where kids 'earn'/, last_response.body
  end

  def test_it_finds_bike_camp
    get '/programs/bike-camp'
    assert last_response.ok?
    assert_match /get around town safely/, last_response.body
  end

  def test_it_finds_bike_rodeo
    get '/programs/bike-rodeo'
    assert last_response.ok?
    assert_match /children 3-13 years of age/,last_response.body
  end

  def test_it_finds_classes
    get '/programs/classes'
    assert last_response.ok?
    assert_match /essential solvents and lubricants/,last_response.body
  end

  def test_it_finds_earn_a_bike
    get '/programs/earn-a-bike'
    assert last_response.ok?
    assert_match /checking for worn\/broken parts/,last_response.body
  end

  def test_it_finds_fix_your_bike
    get '/programs/fix-your-bike'
    assert last_response.ok?
    assert_match /bike clout, cool factor/,last_response.body
  end

  def test_it_finds_support
    get '/support'
    assert last_response.ok?
    assert_match /we can put it to good use/, last_response.body
  end

  def test_it_finds_donate_bikes
    get '/support/donate-bikes'
    assert last_response.ok?
    assert_match /bells, baskets, bike flags/, last_response.body
  end

  def test_it_finds_memberships
    get '/support/memberships'
    assert last_response.ok?
    assert_match /a pesky percentage/, last_response.body
  end

  def test_it_finds_organizing_drive
    get '/support/organizing-drive'
    assert last_response.ok?
    assert_match /effective and enjoyable/, last_response.body
  end

  def test_it_finds_volunteer
    get '/support/volunteer'
    assert last_response.ok?
    assert_match /Craigslist posting, data entry/, last_response.body
  end

  def test_it_finds_wish_list
    get '/support/wish-list'
    assert last_response.ok?
    assert_match /Small Parts Organizer/, last_response.body
  end

  # def test_it_finds_admin_home_page
  #   get '/admin'
  #   assert last_response.ok?
  # end

  # def test_it_posts_admin
  #   post '/admin', :page => {}
  # end

  def test_without_authentication
    get '/admin'
    assert_equal 401, last_response.status
  end

end
