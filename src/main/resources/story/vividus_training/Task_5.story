Scenario: Navigate to the SauceDemo website homepage
When I go to main application page
When I ${baselineAction} baseline with name `loginPage` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|5                         |


Scenario: Log in as a Locked User
When I log in as a user with registered username ${swagLockedUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
Then number of elements found by `${inventoryItem}` is equal to `6`
