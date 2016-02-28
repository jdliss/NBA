gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'open-uri'
require 'nokogiri'
require_relative '../lib/init'

class ScraperTest < Minitest::Test

  def test_can_get_data_from_nba_stats_page
    doc = Nokogiri::HTML(open("http://stats.nba.com"))
    # File.write("nba.html", doc)

    assert doc
  end

  def test_can_parse_data_from_json_input
    json_input = JSON.parse(JSON.generate({"resultSets":[
      {"headers":"John", "rowSet":"Doe"},
      {"headers":"Anna", "rowSet":"Smith"},
      {"headers":"Peter", "rowSet":"Jones"}
      ]}))
    expected = {"John"=>"Doe"}
    not_expected = "Something went wrong"

    assert_equal expected, api_scrape(json_input, 0)
    refute_equal not_expected, api_scrape(json_input, 0)
  end
end
