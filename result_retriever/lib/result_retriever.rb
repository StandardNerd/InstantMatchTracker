require 'watir'

URL_BCZUG4_RESULTS = "https://www.swiss-badminton.ch/league/997197CF-B35F-40FC-983A-0E8FD2D5DC8E/team/360"
URL_BCZUG4_RANKING = "https://www.swiss-badminton.ch/league/997197CF-B35F-40FC-983A-0E8FD2D5DC8E/draw/47"

browser = Watir::Browser.new

browser.goto URL_BCZUG4_RANKING
# browser.link(text: 'Guides').click

cookie_accept = browser.button(class: 'js-accept-basic')
cookie_accept.click

# take a screenshot from current ranking table
current_date = Time.now.strftime('%Y-%m-%d')
browser.window.resize_to(1200, 1600)
browser.screenshot.save "bczug4_ranking_#{current_date}.png"

# get recent match result
browser.goto URL_BCZUG4_RESULTS

# Find the recent Match Result
recent_match = browser.li(div: { class: "score is-not-played" })

# Next Match
next_match = recent_match.find { |li| li.div(class: 'score is-not-played').exists? }

next_match_data = next_match.text.split("\n") # => ["Round 12 • Sa. 13.01.2024", "BC Stansstad 4", "17:00", "BC Zug 4"]

recent_match = next_match.previous_element
sleep 15
browser.close
