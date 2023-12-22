Scenario: Navigate to the SauceDemo website homepage
Given I am on main application page
When I open side menu
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I ${baselineAction1} baseline with name `loginPage`
When I ${baselineAction2} baseline with name `loginPage` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|5                         |


Scenario: Log in as a Good User
When I log in as a user with registered username ${swagGoodUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
When I ${baselineAction1} baseline with name `homePageGoodUser`
When I ${baselineAction2} baseline with name `homePageGoodUser` ignoring:
|ELEMENT                                     |AREA                                  |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="inventory_item_img"])  |By.cssSelector(.inventory_item_img)   |12                        |


Scenario: Log in as a Broken User
When I logged out
When I log in as a user with registered username ${swagBrokenUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html` 
When I ${baselineAction1} baseline with name `homePageBrokenUser`
When I ${baselineAction2} baseline with name `homePageBrokenUser` ignoring:
|ELEMENT                                     |AREA                                  |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="inventory_item_img"])  |By.cssSelector(.inventory_item_img)   |12                        |      
