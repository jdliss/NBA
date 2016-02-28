require 'date'
require 'JSON'
require 'pry'

TODAY = DateTime.now
BASE_URL = "http://stats.nba.com"
HEADERS = {'user-agent': ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) '
                          'AppleWebKit/537.36 (KHTML, like Gecko) '
                          'Chrome/45.0.2454.101 Safari/537.36'),
           'referer': 'http://stats.nba.com/scores/'
          }

def api_scrape(json_input, index)
  # internal method to get data from json

  # Args:
  #       json_input: json input from caller
  #       index: index where data is located

  # Returns:
  #       hash of both headers and values from the page


  begin
    headers = json_input['resultSets'][index]['headers']
    values = json_input['resultSets'][index]['rowSet']

  rescue KeyError
    begin
      headers = json_input['resultSet'][index]['headers']
      values = json_input['resultSet'][index]['rowSet']

    rescue KeyError
      # Added for results that only include one set (ex. LeagueLeaders)
            headers = json_input['resultSet']['headers']
            values = json_input['resultSet']['rowSet']
    end
  end

  headers = [headers] if headers.is_a?(String)
  values = [values] if values.is_a?(String)

  if headers.is_a?(Array) && values.is_a?(Array)
    headers.zip(values).to_h
  else
     "Something went wrong"
  end
end



if __FILE__ == $0
  json_input = JSON.parse(JSON.generate({"resultSets":[
    {"headers":"John", "rowSet":"Doe"},
    {"headers":"Anna", "rowSet":"Smith"},
    {"headers":"Peter", "rowSet":"Jones"}
    ]}))

  3.times do |i|
    puts api_scrape(json_input, i)
  end
end
