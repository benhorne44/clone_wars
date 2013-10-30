ENV['RACK_ENV'] = 'test'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'page_store'
require 'text-converter'

class TextConverterTest < Minitest::Test

  def test_it_exists
    assert TextConverter
  end

  def test_it_converts_to_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        :autolink => true,
                                        :space_after_headers => true)
    sample = "Donated Bicycles are recycled to low income local residents through our [Earn A Bike](/programs/earn-a-bike) programs or refurbished and sold in our bicycle shop to support all of our community service programs."
    expected = "<p>Donated Bicycles are recycled to low income local residents through our <a href=\"/programs/earn-a-bike\">Earn A Bike</a> programs or refurbished and sold in our bicycle shop to support all of our community service programs.</p>\n"
    assert_equal expected, TextConverter.to_html(sample)
  end

end
