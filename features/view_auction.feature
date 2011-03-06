Feature: Auction
  In order to view an auction
  As an guest
  I want to view an auction
  
Scenario: Search Auction
  Given I have page titled burberry
  When I search for burberry
  Then I should see "burberry"
  
# Scenario: View Individual Auction
# #  Given I have page with category Car Documents - Toyota - Mark II
#   Given the following page exists
#     | name                             | category   |
#     | Car Documents - Toyota - Mark II | 2084016551 |
#     | Car Documents - Toyota - Estima  | 2084016571 |
#     | Car Documents - Toyota - RAV4    | 2084016564 |
#   When I search for toyota
#   Then I should see "Car Documents - Toyota - Mark II"
#   When I follow "Car Documents - Toyota - Mark II"
  