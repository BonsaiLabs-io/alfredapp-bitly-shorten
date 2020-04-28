require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('https://api-ssl.bitly.com/v4/shorten')

# Set parameters
params = {
  long_url:  ARGV[0]
}
# Set headers
headers = {
    'Host': 'api-ssl.bitly.com',
    'Authorization': "Bearer #{ENV['BITLY_ACCESS_TOKEN']}",
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}
# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
# Force SSL request
http.use_ssl = true
# Build POST request
request = Net::HTTP::Post.new(uri.request_uri, headers)
# Set request body (As JSON)
request.body = params.to_json
# Send the request
response = http.request(request)
# Get link from response
puts JSON.parse(response.body)['link']
