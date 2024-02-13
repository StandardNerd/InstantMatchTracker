require 'watir'

url_results = "https://www.swiss-badminton.ch/league/997197CF-B35F-40FC-983A-0E8FD2D5DC8E/team/360"
url_ranking = "https://www.swiss-badminton.ch/league/997197CF-B35F-40FC-983A-0E8FD2D5DC8E/draw/47"

# Set up options for Chrome
chrome_options = Selenium::WebDriver::Chrome::Options.new
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-gpu')

browser = Watir::Browser.new :chrome, options: chrome_options

browser.goto url_ranking
# browser.link(text: 'Guides').click

cookie_accept = browser.button(class: 'js-accept-basic')
cookie_accept.click

# take a screenshot from current ranking table
current_date = Time.now.strftime('%Y-%m-%d')
browser.window.resize_to(1200, 1600)
browser.screenshot.save "bczug4_ranking_#{current_date}.png"

# get recent match result
browser.goto url_results

# Find all <li> elements with class name "match-group__item"
li_elements = browser.lis(class: 'match-group__item')

# Display the count of found <li> elements
puts "Number of <li> elements with class 'match-group__item': #{li_elements.length}"

# Next Match
# Find the first li tag that contains a div with class "is-not-played"
next_match = li_elements.find { |li| li.div(class: 'is-not-played').exists? }
next_match_data = next_match.text.split("\n") # => ["Round 12 • Sa. 13.01.2024", "BC Stansstad 4", "17:00", "BC Zug 4"]
p "next_match: #{next_match_data}"

# Find the previous li element relative to the one containing the div with class "is-not-played"
previous_li = next_match.previous_sibling(tag_name: 'li')

# Print the text content of the previous li tag
puts "Text content of the previous li tag:"
puts previous_li.text if previous_li

sleep 5
browser.close
