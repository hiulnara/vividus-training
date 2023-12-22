Scenario: Navigate to the SauceDemo website homepage
Given I am on main application page
When I open side menu
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I ${baselineAction1} baseline with name `loginPage`
When I ${baselineAction2} baseline with name `loginPage` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|5                         |


Scenario: Log in as a Locked User
When I log in as a user with registered username ${swagLockedUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`


Scenario: Navigate to Inventory page
Then number of elements found by `${inventoryItem}` is equal to `6`