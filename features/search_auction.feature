Feature: Searching Auction
  In order to search auctions
  As an guest
  I want to search auction
  
Scenario: Search Auction
  Given I have page titled burberry
  When I search for burberry
  Then I should see "burberry"
  
Scenario: View Individual Auction
  Given the following page exists
    | name                             | category   |
    | Car Documents - Toyota - Mark II | 2084016551 |
    | Car Documents - Toyota - Estima  | 2084016571 |
    | Car Documents - Toyota - RAV4    | 2084016564 |
  When I search for toyota
  Then I should see "Car Documents - Toyota - Mark II"
  And I should see "Car Documents - Toyota - Estima"
  And I should see "Car Documents - Toyota - RAV4"
  When I follow "Car Documents - Toyota - Mark II" 
  And I follow image link "auction-1"
  Then I should see "Seller"
  And I should see "Price"

Scenario: Navigating pages
  Given I have page with seller yahikon1
  When I search for yahikon1
  Then I should see "Listing for yahikon1"
  And I should see "Next"
  When I follow "Next"
  Then I should see "Prev"
  When I follow "Next"
  And I follow "Next"
  Then I should not see "Next"
  When I follow "1"
  Then I should not see "Prev"