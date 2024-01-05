Scenario: Navigate to the SauceDemo website homepage
Given I am on main application page
When I go to main application page
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I ${baselineAction} baseline with name `loginPage` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|5                         |

Scenario: Log in as a Broken User
When I log in as a user with registered username ${swagBrokenUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
When I ${baselineAction} baseline with name `homePageGoodUser` ignoring:
|ELEMENT                                     |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//div[@class="inventory_item_img"])|90                        |
